variable "resource_group_name" {
  description = "Name of the resource group that contains the Terraform state storage."
  type        = string
  default     = "tfstate-rg"
}

variable "location" {
  description = "Azure region where the Terraform state resources are created."
  type        = string
  default     = "East US"
}

variable "storage_account_name_prefix" {
  description = "Lowercase alphanumeric prefix for the globally unique storage account name."
  type        = string
  default     = "tfstate"

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.storage_account_name_prefix)) && length(var.storage_account_name_prefix) >= 1 && length(var.storage_account_name_prefix) <= 18
    error_message = "storage_account_name_prefix must be 1-18 lowercase letters or numbers."
  }
}

variable "container_name" {
  description = "Name of the private blob container used for Terraform state."
  type        = string
  default     = "tfstate"
}

variable "tags" {
  description = "Tags applied to the remote state backend resources."
  type        = map(string)
  default = {
    Scope     = "global"
    Purpose   = "TerraformRemoteState"
    ManagedBy = "Terraform"
  }
}

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
  default     = "bab79429-6d4a-482f-9cb9-e76d165fd4ae"
}
