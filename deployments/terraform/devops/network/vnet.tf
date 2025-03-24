// vnet.tf

resource "azurerm_virtual_network" "vnet" {
  count = var.deploy_network ? 1 : 0

  name                = local.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  address_space = [var.network.vnet_address_prefix]
}

#
# Subnets
#

# Subnet for Private Endpoints
resource "azurerm_subnet" "private_endpoints" {
  name                 = local.private_endpoints_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
  address_prefixes     = [var.network.private_endpoints_subnet_prefix]

  depends_on = [
    azurerm_virtual_network.vnet,
  ]
}

# Subnet for Jumpbox
resource "azurerm_subnet" "jumpbox" {
  name                 = local.jumpbox_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
  address_prefixes     = [var.network.jumpbox_subnet_prefix]

  depends_on = [
    azurerm_virtual_network.vnet,
  ]
}

# Subnet for Bastion
resource "azurerm_subnet" "azure_bastion" {
  name                 = local.bastion_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
  address_prefixes     = [var.network.bastion_subnet_prefix]

  depends_on = [
    azurerm_virtual_network.vnet,
  ]
}
