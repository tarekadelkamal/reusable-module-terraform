terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatedj0qlo"
    container_name       = "tfstate"
    key                  = "terraform.dev.tfstate"
  }
}
