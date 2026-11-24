subscription_id = "bab79429-6d4a-482f-9cb9-e76d165fd4ae"

# Resource Group
resource_group_name = "rg-app-dev"
location            = "East US"

# Network
vnet_name          = "vnet-app-dev"
vnet_address_space = ["10.10.0.0/16"]
nsg_name           = "nsg-app-dev"
allowed_ssh_cidr   = "0.0.0.0/0"

subnets = {
  vm = {
    address_prefix = "10.10.1.0/24"
  }
  app = {
    address_prefix = "10.10.2.0/24"
  }
  aks = {
    address_prefix = "10.10.3.0/24"
  }
}

# Storage Account
storage_account_name             = "stappdevtf2026"
storage_account_tier             = "Standard"
storage_account_replication_type = "LRS"
storage_container_name           = "dev-data"

# Azure Container Registry
acr_name          = "acrappdev2026"
acr_sku           = "Basic"
acr_admin_enabled = true

# Virtual Machine
vm_name             = "vm-app-dev"
vm_size             = "Standard_D2as_v4"
vm_enable_public_ip = true
vm_admin_username   = "azureuser"
vm_admin_password   = "DevP@ssw0rd2026!"
vm_os_disk_type     = "Standard_LRS"
vm_os_disk_size_gb  = 30

# AKS Cluster
aks_cluster_name          = "aks-app-dev"
aks_dns_prefix            = "aks-app-dev"
aks_kubernetes_version    = "1.35.9"
aks_system_node_count     = 1
aks_system_vm_size        = "Standard_D2as_v4"
aks_enable_user_node_pool = false
aks_service_cidr          = "10.100.0.0/16"
aks_dns_service_ip        = "10.100.0.10"

# Tags
tags = {
  Environment = "dev"
  ManagedBy   = "Terraform"
  Project     = "Reusability"
}
