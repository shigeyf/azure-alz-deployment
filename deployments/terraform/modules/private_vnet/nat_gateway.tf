// nat_gateway.tf

resource "azurerm_public_ip" "this" {
  count               = var.vnet_configs.enable_nat_gateway ? 1 : 0
  name                = local.nat_gateway_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
}

resource "azurerm_nat_gateway" "this" {
  count               = var.vnet_configs.enable_nat_gateway ? 1 : 0
  name                = local.nat_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  count                = var.vnet_configs.enable_nat_gateway ? 1 : 0
  nat_gateway_id       = azurerm_nat_gateway.this[0].id
  public_ip_address_id = azurerm_public_ip.this[0].id
}
