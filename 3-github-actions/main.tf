variable "az_sub" {
    type = string
    description = "Azure Subscription ID string"
}

terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 2.0"

        }
    }
}

provider "azurerm" {
    subscription_id = var.az_sub
    features {}
}

resource "azurerm_resource_group" "test_rg" {
  name     = "Test"
  location = "eastus"

  tags = {
    environment = "Dev"
  }
}