output "storage_account_id" {
  description = "ID of the Storage Account"
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "Name of the Storage Account"
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "Primary Blob Endpoint URL"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "container_name" {
  description = "Container name if created"
  value       = var.container_name != null && var.container_name != "" ? azurerm_storage_container.this[0].name : null
}
