// locals.tf

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
  suffix-padding = 12
}

locals {
  location_short_name = module.azure_region.location_short

  // Resource names
  container_app_environment_name = module.naming.container_app_environment.name_unique
  container_app_environment_rg_name = join("-", [
    module.naming.resource_group.name_unique,
    module.naming.container_app_environment.slug,
    "infra",
  ])
}
