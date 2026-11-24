
#############################
# Core
#############################
variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group that will contain the AKS cluster."
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the cluster API server."
}

variable "kubernetes_version" {
  type        = string
  description = "Full Kubernetes version string supported in your region (e.g. '1.35.9'). Set null to let Azure manage it."
  default     = null
}

#############################
# Default (System) Node Pool
#############################
variable "system_node_count" {
  type        = number
  description = "Number of nodes in the system node pool."
  default     = 2
}

variable "system_vm_size" {
  type        = string
  description = "VM size for system node pool."
  default     = "Standard_D2s_v3"
}

variable "os_disk_size_gb" {
  type        = number
  description = "OS disk size in GB for nodes."
  default     = 128
}

#############################
# User Node Pool
#############################
variable "enable_user_node_pool" {
  type        = bool
  description = "Whether to create a separate user/workload node pool."
  default     = false
}

variable "user_node_count" {
  type        = number
  description = "Number of nodes in the user node pool."
  default     = 2
}

variable "user_vm_size" {
  type        = string
  description = "VM size for user node pool."
  default     = "Standard_D4s_v3"
}

#############################
# Networking
#############################
variable "aks_subnet_id" {
  type        = string
  description = "Subnet ID for AKS nodes."
}

variable "network_plugin" {
  type        = string
  description = "Network plugin: 'azure' (CNI) or 'kubenet'."
  default     = "azure"
}

variable "network_policy" {
  type        = string
  description = "Network policy: 'azure' or 'calico'."
  default     = "azure"
}

variable "service_cidr" {
  type        = string
  description = "CIDR for Kubernetes services (must not overlap VNet)."
  default     = "10.100.0.0/16"
}

variable "dns_service_ip" {
  type        = string
  description = "IP for the Kubernetes DNS service, within service_cidr."
  default     = "10.100.0.10"
}

#############################
# Node Provisioning
#############################
variable "node_provisioning_mode" {
  type        = string
  description = "Node provisioning mode: 'Manual' (default, standard node pools) or 'Auto' (Node Auto-Provisioning / Karpenter)."
  default     = "Manual"

  validation {
    condition     = contains(["Auto", "Manual"], var.node_provisioning_mode)
    error_message = "Valid values: Auto, Manual."
  }
}

#############################
# AAD RBAC
#############################
variable "tenant_id" {
  type        = string
  description = "Azure AD tenant ID for AAD RBAC integration (optional)."
  default     = null
}

variable "admin_group_object_ids" {
  type        = list(string)
  description = "List of AAD group object IDs granted cluster admin access."
  default     = []
}

#############################
# Monitoring
#############################
variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics Workspace resource ID. Set null to disable OMS agent."
  default     = null
}

#############################
# Upgrade
#############################
variable "automatic_upgrade_channel" {
  type        = string
  description = "Auto-upgrade channel: 'patch', 'rapid', 'stable', or 'node-image'."
  default     = "patch"

  validation {
    condition     = contains(["patch", "rapid", "stable", "node-image"], var.automatic_upgrade_channel)
    error_message = "Valid values: patch, rapid, stable, node-image."
  }
}

#############################
# Tags
#############################
variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources."
  default     = {}
}
