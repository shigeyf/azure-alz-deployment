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
    [join("", [var.naming_conventions.suffix[0], "vnet"])],
    slice(var.naming_conventions.suffix, 1, length(var.naming_conventions.suffix)),
    [local.location_short_name],
  )
  suffix-padding = 8
}

locals {
  location_short_name      = module.azure_region.location_short
  subnet_prefix            = module.naming.subnet.slug
  bastion_suffix           = "bastion"
  jumpbox_suffix           = "jumpbox"
  private_endpoints_suffix = "pes"

  // VNet name
  vnet_name = module.naming.virtual_network.name_unique

  // Subnet names
  bastion_subnet_name           = "AzureBastionSubnet"
  jumpbox_subnet_name           = join("-", [local.subnet_prefix, local.jumpbox_suffix])
  private_endpoints_subnet_name = join("-", [local.subnet_prefix, local.private_endpoints_suffix])

  // NSG names
  bastion_subnet_nsg_name = join("-", [
    module.naming.network_security_group.name_unique_with_pad,
    local.bastion_suffix,
  ])
  jumpbox_subnet_nsg_name = join("-", [
    module.naming.network_security_group.name_unique_with_pad,
    local.jumpbox_suffix,
  ])
  public_endpoints_subnet_nsg_name = join("-", [
    module.naming.network_security_group.name_unique_with_pad,
    local.private_endpoints_suffix,
  ])
}
