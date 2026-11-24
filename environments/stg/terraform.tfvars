subscription_id = "bab79429-6d4a-482f-9cb9-e76d165fd4ae"

# Resource Group
resource_group_name = "rg-app-stg"
location            = "East US"

# Network
vnet_name          = "vnet-app-stg"
vnet_address_space = ["10.20.0.0/16"]
nsg_name           = "nsg-app-stg"
allowed_ssh_cidr   = "0.0.0.0/0"

subnets = {
  vm = {
    address_prefix = "10.20.1.0/24"
  }
  app = {
    address_prefix = "10.20.2.0/24"
  }
  aks = {
    address_prefix = "10.20.3.0/24"
  }
}

# Storage Account
storage_account_name             = "stappstgtf2026"
storage_account_tier             = "Standard"
storage_account_replication_type = "LRS"
storage_container_name           = "stg-data"

# Azure Container Registry
acr_name          = "acrappstg2026"
acr_sku           = "Standard"
acr_admin_enabled = true

# Virtual Machine
vm_name             = "vm-app-stg"
vm_size             = "Standard_D2as_v4"
vm_enable_public_ip = false
vm_admin_username   = "azureuser"
vm_admin_password   = "StgP@ssw0rd2026!"
vm_os_disk_type     = "Standard_LRS"
vm_os_disk_size_gb  = 30

# AKS Cluster
aks_cluster_name          = "aks-app-stg"
aks_dns_prefix            = "aks-app-stg"
aks_kubernetes_version    = "1.35.9"
aks_system_node_count     = 2
aks_system_vm_size        = "Standard_D2as_v4"
aks_enable_user_node_pool = false
aks_service_cidr          = "10.200.0.0/16"
aks_dns_service_ip        = "10.200.0.10"

# Tags
tags = {
  Environment = "stg"
  ManagedBy   = "Terraform"
  Project     = "Reusability"
}
