// local.tf

// Load a module for Azure Region names and short names
module "azure_region" {
  source       = "claranet/regions/azurerm"
  version      = "8.0.1"
  azure_region = var.location
}

// Load a module for Azure Resource naming
module "naming" {
  //source  = "Azure/naming/azurerm"
  //version = " >= 0.4.0"
  source         = "../../externals/terraform-azurerm-naming"
  suffix         = concat(var.naming_suffix, [local.location_short_name])
  suffix-padding = 4
}

locals {
  // Fixed values
  public_ip_allocation_method = "Static"
  public_ip_sku               = "Standard"

  location_short_name = module.azure_region.location_short

  // Resource names
  bastion_pip_name = module.naming.public_ip.name_unique
  bastion_name     = module.naming.bastion_host.name_unique
}
