output "resource_group_name" {
  description = "Name of the resource group containing the Terraform remote state storage."
  value       = azurerm_resource_group.tfstate.name
}

output "resource_group_id" {
  description = "ID of the resource group containing the Terraform remote state storage."
  value       = azurerm_resource_group.tfstate.id
}

output "storage_account_name" {
  description = "Name of the Terraform remote state storage account."
  value       = azurerm_storage_account.tfstate.name
}

output "storage_account_id" {
  description = "ID of the Terraform remote state storage account."
  value       = azurerm_storage_account.tfstate.id
}

output "container_name" {
  description = "Name of the private Terraform remote state blob container."
  value       = azurerm_storage_container.tfstate.name
}

output "backend_config_reference" {
  description = "Reference block to copy into environment backend.tf files"
  value       = <<EOT
terraform {
  backend "azurerm" {
    resource_group_name  = "${azurerm_resource_group.tfstate.name}"
    storage_account_name = "${azurerm_storage_account.tfstate.name}"
    container_name       = "${azurerm_storage_container.tfstate.name}"
    key                  = "terraform.<env>.tfstate"
  }
}
EOT
}
