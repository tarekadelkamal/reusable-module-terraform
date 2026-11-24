output "resource_group_name" {
  description = "Name of the Resource Group"
  value       = module.resource_group.name
}

output "resource_group_id" {
  description = "ID of the Resource Group"
  value       = module.resource_group.id
}

output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = module.network.vnet_id
}

output "subnet_ids" {
  description = "Subnet IDs map"
  value       = module.network.subnet_ids
}

output "nsg_id" {
  description = "NSG ID"
  value       = module.network.nsg_id
}

output "storage_account_name" {
  description = "Storage account name"
  value       = module.storage.storage_account_name
}

output "storage_account_id" {
  description = "Storage account ID"
  value       = module.storage.storage_account_id
}

output "acr_name" {
  description = "ACR name"
  value       = module.acr.acr_name
}

output "acr_login_server" {
  description = "ACR login server URL"
  value       = module.acr.login_server
}

output "vm_id" {
  description = "Virtual Machine ID"
  value       = module.virtual_machine.vm_id
}

output "vm_name" {
  description = "Virtual Machine name"
  value       = module.virtual_machine.vm_name
}

output "vm_private_ip" {
  description = "Virtual Machine private IP"
  value       = module.virtual_machine.private_ip_address
}

output "vm_public_ip" {
  description = "Virtual Machine public IP"
  value       = module.virtual_machine.public_ip_address
}

output "aks_cluster_name" {
  description = "AKS Cluster name"
  value       = module.aks.cluster_name
}

output "aks_cluster_id" {
  description = "AKS Cluster ID"
  value       = module.aks.cluster_id
}

output "aks_host" {
  description = "AKS Cluster API server endpoint"
  value       = module.aks.host
  sensitive   = true
}
