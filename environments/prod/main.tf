#############################
# Azure Resource Group
#############################
module "resource_group" {
  source   = "../../modules/resource-group"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

#############################
# Network (VNet, Subnets, NSGs)
#############################
module "network" {
  source = "../../modules/network"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vnet_name           = var.vnet_name
  address_space       = var.vnet_address_space
  nsg_name            = var.nsg_name
  allowed_ssh_cidr    = var.allowed_ssh_cidr
  subnets             = var.subnets
  tags                = var.tags
}

#############################
# Storage Account
#############################
module "storage" {
  source = "../../modules/storage"

  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location
  storage_account_name     = var.storage_account_name
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  container_name           = var.storage_container_name
  tags                     = var.tags
}

#############################
# Azure Container Registry (ACR)
#############################
module "acr" {
  source = "../../modules/acr"

  acr_name            = var.acr_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  sku                 = var.acr_sku
  admin_enabled       = var.acr_admin_enabled
  tags                = var.tags
}

#############################
# Virtual Machine
#############################
module "virtual_machine" {
  source = "../../modules/virtual-machine"

  vm_name              = var.vm_name
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  subnet_id            = module.network.subnet_ids["vm"]
  vm_size              = var.vm_size
  enable_public_ip     = var.vm_enable_public_ip
  admin_username       = var.vm_admin_username
  admin_password       = var.vm_admin_password
  admin_ssh_public_key = var.vm_admin_ssh_public_key
  os_disk_type         = var.vm_os_disk_type
  os_disk_size_gb      = var.vm_os_disk_size_gb
  tags                 = var.tags
}

#############################
# AKS Cluster
#############################
module "aks" {
  source = "../../modules/aks"

  cluster_name        = var.aks_cluster_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  dns_prefix          = var.aks_dns_prefix
  kubernetes_version  = var.aks_kubernetes_version

  # Node pools
  system_node_count     = var.aks_system_node_count
  system_vm_size        = var.aks_system_vm_size
  enable_user_node_pool = var.aks_enable_user_node_pool
  user_node_count       = var.aks_user_node_count
  user_vm_size          = var.aks_user_vm_size
  os_disk_size_gb       = var.aks_os_disk_size_gb

  # Networking
  aks_subnet_id  = module.network.subnet_ids["aks"]
  network_plugin = var.aks_network_plugin
  network_policy = var.aks_network_policy
  service_cidr   = var.aks_service_cidr
  dns_service_ip = var.aks_dns_service_ip

  # Monitoring
  log_analytics_workspace_id = var.aks_log_analytics_workspace_id

  tags = var.tags
}

#############################
# AKS to ACR Role Assignment (AcrPull)
#############################
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = module.acr.acr_id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_identity[0].object_id
}
