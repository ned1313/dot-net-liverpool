terraform {
    backend "azurerm" {
        container_name = "terraform-state"
        key = "terraform.tfstate"
    }
}