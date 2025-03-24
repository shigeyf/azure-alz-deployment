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
    [join("", [var.naming_conventions.suffix[0], "jumpstart"])],
    slice(var.naming_conventions.suffix, 1, length(var.naming_conventions.suffix)),
    [local.location_short_name],
  )
  suffix-padding = 16
}

locals {
  location_short_name = module.azure_region.location_short
  //osdisk_suffix       = "osdisk"

  vm_name = module.naming.virtual_machine.short_name_unique
  //vm_os_disk_name = join("-", [local.osdisk_suffix, local.vm_name])
  vm_nic_name = join("-", [
    module.naming.network_interface.name_with_pad,
    local.vm_name,
  ])

  bastion_pip_name = module.naming.public_ip.name_unique
  bastion_name     = module.naming.bastion_host.name_unique
}
