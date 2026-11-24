variable "vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the VM NIC will be connected"
  type        = string
}

variable "vm_size" {
  description = "Virtual machine size / SKU"
  type        = string
  default     = "Standard_B2s"
}

variable "enable_public_ip" {
  description = "Whether to allocate a public IP for the VM"
  type        = bool
  default     = false
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  description = "Public SSH key for authentication. If null, admin_password is used."
  type        = string
  default     = null
}

variable "admin_password" {
  description = "Admin password if SSH key is not provided"
  type        = string
  default     = "P@ssw0rd1234!"
  sensitive   = true
}

variable "os_disk_type" {
  description = "Type of OS disk (Standard_LRS, Premium_LRS, StandardSSD_LRS)"
  type        = string
  default     = "Standard_LRS"
}

variable "os_disk_size_gb" {
  description = "Size of the OS disk in GB"
  type        = number
  default     = 30
}

variable "image_publisher" {
  description = "Publisher of the OS image"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "Offer of the OS image"
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
  description = "SKU of the OS image"
  type        = string
  default     = "22_04-lts"
}

variable "image_version" {
  description = "Version of the OS image"
  type        = string
  default     = "latest"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
