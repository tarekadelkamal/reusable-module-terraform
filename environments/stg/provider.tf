terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.14"
    }
  }
}

# Authenticates via Azure CLI (az login)
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
