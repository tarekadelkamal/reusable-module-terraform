subscription_id = "bab79429-6d4a-482f-9cb9-e76d165fd4ae"


# Resource Group
resource_group_name = "rg-app-prod"
location            = "East US"

# Network
vnet_name          = "vnet-app-prod"
vnet_address_space = ["10.30.0.0/16"]
nsg_name           = "nsg-app-prod"
allowed_ssh_cidr   = "10.0.0.0/8"

subnets = {
  vm = {
    address_prefix = "10.30.1.0/24"
  }
  app = {
    address_prefix = "10.30.2.0/24"
  }
  aks = {
    address_prefix = "10.30.3.0/24"
  }
}

# Storage Account
storage_account_name             = "stappprodtf2026"
storage_account_tier             = "Standard"
storage_account_replication_type = "GRS"
storage_container_name           = "prod-data"

# Azure Container Registry
acr_name          = "acrappprod2026"
acr_sku           = "Premium"
acr_admin_enabled = false

# Virtual Machine
vm_name             = "vm-app-prod"
vm_size             = "Standard_D4as_v4"
vm_enable_public_ip = false
vm_admin_username   = "azureuser"
vm_admin_password   = "ProdP@ssw0rd2026!Secure"
vm_os_disk_type     = "Premium_LRS"
vm_os_disk_size_gb  = 64

# AKS Cluster
aks_cluster_name          = "aks-app-prod"
aks_dns_prefix            = "aks-app-prod"
aks_kubernetes_version    = "1.35.9"
aks_system_node_count     = 3
aks_system_vm_size        = "Standard_D4as_v4"
aks_enable_user_node_pool = true
aks_user_node_count       = 3
aks_user_vm_size          = "Standard_D4as_v4"
aks_service_cidr          = "10.250.0.0/16"
aks_dns_service_ip        = "10.250.0.10"

# Tags
tags = {
  Environment = "prod"
  ManagedBy   = "Terraform"
  Project     = "Reusability"
  Criticality = "High"
}
