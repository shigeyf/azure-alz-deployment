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
  // Fixed values
  vm_os_type_linux   = "linux"
  vm_os_type_windows = "windows"
  vm_password_length = 20

  location_short_name = module.azure_region.location_short

  // Resource names
  vm_name          = module.naming.virtual_machine.short_name_unique
  vm_nic_name      = join("-", [module.naming.network_interface.name_with_pad, local.vm_name])
  vm_password_name = join("-", ["password", local.vm_name])
  vm_ssh_key_name  = join("-", ["ssh-key", local.vm_name])
}
