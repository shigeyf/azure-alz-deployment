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
  source = "../../externals/terraform-azurerm-naming"
  suffix = concat(
    [join("", [var.naming_conventions.suffix[0], "tfbe"])],
    slice(var.naming_conventions.suffix, 1, length(var.naming_conventions.suffix)),
    [local.location_short_name],
  )
  suffix-padding = 4
}

locals {
  location_short_name = module.azure_region.location_short

  // names
  keyvault_name        = module.naming.key_vault.short_name_unique
  keyvault_pe_name     = join("-", [module.naming.private_endpoint.name_unique_with_pad, module.naming.key_vault.slug])
  storage_umi_name     = module.naming.user_assigned_identity.name_unique
  storage_account_name = module.naming.storage_account.short_name_unique
  storage_cmkey_name   = join("-", ["cmkey", local.storage_account_name])
  storage_pe_name      = join("-", [module.naming.private_endpoint.name_unique_with_pad, module.naming.storage_account.slug])
}
