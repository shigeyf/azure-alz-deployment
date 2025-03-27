// vnet.tf

resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  address_space = [var.vnet_configs.address_prefix]
}
