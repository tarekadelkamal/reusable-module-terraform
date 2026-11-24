output "vm_id" {
  description = "ID of the Virtual Machine"
  value       = azurerm_linux_virtual_machine.this.id
}

output "vm_name" {
  description = "Name of the Virtual Machine"
  value       = azurerm_linux_virtual_machine.this.name
}

output "private_ip_address" {
  description = "Private IP address of the Virtual Machine"
  value       = azurerm_linux_virtual_machine.this.private_ip_address
}

output "public_ip_address" {
  description = "Public IP address of the Virtual Machine (if enabled)"
  value       = var.enable_public_ip ? azurerm_public_ip.this[0].ip_address : null
}

output "nic_id" {
  description = "ID of the Network Interface"
  value       = azurerm_network_interface.this.id
}
