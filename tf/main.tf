terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}


module "networking" {
  source              = "./modules/networking"
  location            = var.location
  rg                  = var.rg
  hmip                = var.hmip
}

module "compute" {
  source           = "./modules/compute"
  location         = var.location
  rg               = module.networking.resource_group_name
  nicid            = module.networking.nic_id
  admin_username   = var.admin_username
  admin_password   = var.admin_password
}
