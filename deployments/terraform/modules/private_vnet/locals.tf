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
  suffix-padding = 16
}

locals {
  location_short_name  = module.azure_region.location_short
  subnet_naming_prefix = module.naming.subnet.slug

  // Resource names
  vnet_name = module.naming.virtual_network.name_unique
}
