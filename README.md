# Reusable Infrastructure as Code with Terraform on Azure

This repository demonstrates the principles of **Terraform Reusability** across multiple isolated environments:
- **Global Remote State Backend**: `global/` (or `modules/global/`)
- **Development (DEV)**: `environments/dev/`
- **Staging (STG)**: `environments/stg/`
- **Production (PROD)**: `environments/prod/`

Each environment deploys the exact same infrastructure components using shared, parameterized child modules.

---

## Architecture Overview

```text
reusability terraform/
├── global/                   # Dedicated Remote State Backend Bootstrap
│   ├── main.tf               # Provisions RG, Storage Account & Blob Container for tfstate ONLY
│   ├── variables.tf          # Configurable prefix, region, tags
│   ├── outputs.tf            # Remote state backend reference details
│   └── provider.tf           # AzureRM provider configuration
├── modules/                  # Reusable Child Modules (DRY)
│   ├── resource-group/       # Azure Resource Group
│   ├── network/              # VNet, Subnets, and NSG (bundled together)
│   ├── storage/              # Azure Storage Account & Container (for workload data)
│   ├── acr/                  # Azure Container Registry
│   ├── virtual-machine/      # Linux Virtual Machine with NIC & optional PIP
│   └── aks/                  # Azure Kubernetes Service Cluster & Node Pools
└── environments/             # Application Environments (using remote state backend)
    ├── dev/                  # Development Environment (remote state key: terraform.dev.tfstate)
    ├── stg/                  # Staging Environment (remote state key: terraform.stg.tfstate)
    └── prod/                 # Production Environment (remote state key: terraform.prod.tfstate)
```

---

## 1. Global Module: Remote State Only

The **`global`** module is reserved strictly and exclusively for bootstrapping and hosting the **Terraform Remote State Backend**:
- **Resource Group**: `tfstate-rg`
- **Storage Account**: `tfstate<suffix>` (TLS 1.2, private blob access, encrypted)
- **Blob Container**: `tfstate`

> **Note**: `global` contains **no application resources** (no VNets, subnets, NSGs, VMs, ACR, or AKS). Workload storage accounts needed by the environments are provisioned independently per environment via `modules/storage`.

### Environment Backend Connection
Each environment's `backend.tf` references the resources provisioned by `global`:
```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "<storage_account_name_from_global>"
    container_name       = "tfstate"
    key                  = "terraform.<dev|stg|prod>.tfstate"

    use_azuread_auth = true
    use_cli          = true
  }
}
```

---

## 2. Infrastructure Components Deployed in Each Environment

All 3 environments provision the following infrastructure resources:

1. **Azure Resource Group** (`modules/resource-group`):
   - Isolated lifecycle boundary per environment (`rg-app-dev`, `rg-app-stg`, `rg-app-prod`).
2. **Virtual Network & Subnets & NSGs** (`modules/network`):
   - Virtual Network with non-overlapping address spaces.
   - Dedicated subnets for `vm`, `app`, and `aks`.
   - Network Security Group with customizable inbound rules (HTTPS, SSH) associated with subnets.
3. **Storage Account** (`modules/storage`):
   - Dedicated application data storage with configurable replication (`LRS` for DEV/STG, `GRS` for PROD) and security settings.
4. **Azure Container Registry (ACR)** (`modules/acr`):
   - Scalable SKU (`Basic` for DEV, `Standard` for STG, `Premium` for PROD).
5. **Virtual Machine** (`modules/virtual-machine`):
   - Linux VM (Ubuntu Jammy 22.04 LTS), network interface in the `vm` subnet, configurable public/private IP, disk sizing, and credentials.
6. **Azure Kubernetes Service (AKS)** (`modules/aks`):
   - Managed Kubernetes cluster inside the `aks` subnet with Azure CNI/Kubenet, RBAC, node pools, and auto-upgrades.
7. **AKS to ACR Integration**:
   - Native `AcrPull` role assignment connecting the AKS kubelet identity to the Container Registry.

---

## 3. Environment Comparison Matrix

| Configuration | DEV (`environments/dev`) | STG (`environments/stg`) | PROD (`environments/prod`) |
| :--- | :--- | :--- | :--- |
| **Resource Group** | `rg-app-dev` | `rg-app-stg` | `rg-app-prod` |
| **VNet CIDR** | `10.10.0.0/16` | `10.20.0.0/16` | `10.30.0.0/16` |
| **VM Subnet** | `10.10.1.0/24` | `10.20.1.0/24` | `10.30.1.0/24` |
| **App Subnet** | `10.10.2.0/24` | `10.20.2.0/24` | `10.30.2.0/24` |
| **AKS Subnet** | `10.10.3.0/24` | `10.20.3.0/24` | `10.30.3.0/24` |
| **SSH Allowed CIDR** | `0.0.0.0/0` (open for dev) | `0.0.0.0/0` | `10.0.0.0/8` (restricted) |
| **Storage Account** | `stappdevtf2026` (`LRS`) | `stappstgtf2026` (`LRS`) | `stappprodtf2026` (`GRS`) |
| **Container Registry**| `Basic` (admin enabled) | `Standard` | `Premium` (zero admin keys) |
| **Virtual Machine** | `Standard_B2s` (Public IP) | `Standard_B2s` (Private only)| `Standard_D4s_v5` (Private only)|
| **AKS System Nodes** | 1 Node (`Standard_D2s_v3`)| 2 Nodes (`Standard_D2s_v3`) | 3 Nodes (`Standard_D4s_v3`) |
| **AKS User Pool** | Disabled | Disabled | Enabled (3 Nodes, `Standard_D4s_v3`)|
| **AKS Service CIDR**| `10.100.0.0/16` | `10.200.0.0/16` | `10.250.0.0/16` |
| **State File Key** | `terraform.dev.tfstate` | `terraform.stg.tfstate` | `terraform.prod.tfstate` |

---

## 4. How Reusability Is Achieved

1. **DRY (Don't Repeat Yourself)**:
   - Module definitions (`modules/`) encapsulate the resource blocks, associations, and Azure configurations.
   - Root modules (`environments/{dev,stg,prod}/main.tf`) do not define raw Azure resources; they instantiate child modules.
2. **Environment Divergence via Variables**:
   - Environment-specific sizing, networking, and tier differences live exclusively in `terraform.tfvars`.
   - `main.tf` is identical in structure across all environments.
3. **Blast Radius & State Isolation**:
   - Each environment maintains its own remote state file (`terraform.<env>.tfstate`).
   - Changes or issues in DEV cannot corrupt or impact STG or PROD.

---

## 5. Deployment Workflow

### Step 1: Bootstrap Remote State (Global)
```bash
cd global
terraform init
terraform apply
```

### Step 2: Deploy Environments
```bash
# Deploy DEV:
cd ../environments/dev
terraform init
terraform plan
terraform apply

# Deploy STG:
cd ../stg
terraform init
terraform plan
terraform apply

# Deploy PROD:
cd ../prod
terraform init
terraform plan
terraform apply
```
