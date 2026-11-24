variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
  default     = "bab79429-6d4a-482f-9cb9-e76d165fd4ae"
}

variable "tenant_id" {
  type        = string
  description = "Azure AD Tenant ID (optional, leave null when using Azure CLI auth)"
  default     = null
}

#############################
# Resource Group
#############################
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "East US"
}

#############################
# Network
#############################
variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the Virtual Network"
}

variable "subnets" {
  type = map(object({
    address_prefix = string
    associate_nsg  = optional(bool, true)
  }))
  description = "Map of subnets to create"
}

variable "nsg_name" {
  type        = string
  description = "Name of the Network Security Group"
  default     = "nsg-default"
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "Allowed CIDR for SSH access"
  default     = "0.0.0.0/0"
}

#############################
# Storage Account
#############################
variable "storage_account_name" {
  type        = string
  description = "Globally unique name of the storage account (3-24 alphanumeric lowercase)"
}

variable "storage_account_tier" {
  type        = string
  description = "Storage account tier"
  default     = "Standard"
}

variable "storage_account_replication_type" {
  type        = string
  description = "Storage replication strategy (LRS, GRS, ZRS)"
  default     = "LRS"
}

variable "storage_container_name" {
  type        = string
  description = "Storage container name"
  default     = null
}

#############################
# Azure Container Registry (ACR)
#############################
variable "acr_name" {
  type        = string
  description = "Globally unique name for the Azure Container Registry"
}

variable "acr_sku" {
  type        = string
  description = "ACR SKU (Basic, Standard, Premium)"
  default     = "Standard"
}

variable "acr_admin_enabled" {
  type        = bool
  description = "Enable admin user on ACR"
  default     = false
}

#############################
# Virtual Machine
#############################
variable "vm_name" {
  type        = string
  description = "Name of the Linux VM"
}

variable "vm_size" {
  type        = string
  description = "VM size/SKU"
  default     = "Standard_B2s"
}

variable "vm_enable_public_ip" {
  type        = bool
  description = "Whether to assign a public IP to the VM"
  default     = false
}

variable "vm_admin_username" {
  type        = string
  description = "Admin username for the VM"
  default     = "azureuser"
}

variable "vm_admin_password" {
  type        = string
  description = "Admin password for the VM (used if SSH key not set)"
  default     = "P@ssw0rd1234!"
  sensitive   = true
}

variable "vm_admin_ssh_public_key" {
  type        = string
  description = "SSH public key for the VM"
  default     = null
}

variable "vm_os_disk_type" {
  type        = string
  description = "OS disk storage type"
  default     = "Standard_LRS"
}

variable "vm_os_disk_size_gb" {
  type        = number
  description = "OS disk size in GB"
  default     = 30
}

#############################
# AKS Variables
#############################
variable "aks_cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "aks_dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster"
}

variable "aks_kubernetes_version" {
  type        = string
  description = "Kubernetes version"
  default     = "1.35.9"
}

variable "aks_system_node_count" {
  type        = number
  description = "System node pool count"
  default     = 2
}

variable "aks_system_vm_size" {
  type        = string
  description = "VM size for system node pool"
  default     = "Standard_D2s_v3"
}

variable "aks_enable_user_node_pool" {
  type        = bool
  description = "Enable separate user node pool"
  default     = false
}

variable "aks_user_node_count" {
  type        = number
  description = "User node pool count"
  default     = 2
}

variable "aks_user_vm_size" {
  type        = string
  description = "VM size for user node pool"
  default     = "Standard_D4s_v3"
}

variable "aks_os_disk_size_gb" {
  type        = number
  description = "Node OS disk size in GB"
  default     = 128
}

variable "aks_network_plugin" {
  type        = string
  description = "Network plugin ('azure' or 'kubenet')"
  default     = "azure"
}

variable "aks_network_policy" {
  type        = string
  description = "Network policy ('azure' or 'calico')"
  default     = "azure"
}

variable "aks_service_cidr" {
  type        = string
  description = "CIDR range for Kubernetes services"
  default     = "10.100.0.0/16"
}

variable "aks_dns_service_ip" {
  type        = string
  description = "IP for the Kubernetes DNS service"
  default     = "10.100.0.10"
}

variable "aks_log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics Workspace ID for AKS monitoring"
  default     = null
}

variable "aks_admin_group_object_ids" {
  type        = list(string)
  description = "AAD group object IDs granted admin access to AKS"
  default     = []
}

#############################
# Tags
#############################
variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
