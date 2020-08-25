###########################
# CONFIGURATION
###########################

terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 2.0"

        }
    }
}

###########################
# VARIABLES
###########################

variable "region" {
    type = string
    description = "Region in Azure"
    default = "eastus"
}

variable "prefix" {
    type = string
    description = "prefix for naming"
    default = "dnl"
}

###########################
# PROVIDERS
###########################

provider "azurerm" {
    features = {}
    region = var.region
}

###########################
# DATA SOURCES
###########################

locals {
    name = "${var.prefix}-${random_integer.prefix_num.result}"
}

###########################
# RESOURCES
###########################

resource "random_integer" "prefix_num" {
  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "aks" {
  name     = local.name
  location = var.region
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = local.name
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = local.name

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

###########################
# OUTPUTS
###########################

