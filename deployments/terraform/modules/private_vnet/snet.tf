// snet.tf

resource "azurerm_subnet" "snet" {
  for_each = var.vnet_configs.subnets

  name                 = each.value.naming_prefix_enabled ? "${local.subnet_naming_prefix}-${each.value.name}" : each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value.address_prefix]

  dynamic "delegation" {
    for_each = each.value.delegation != null ? each.value.delegation : []
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }

  depends_on = [
    azurerm_virtual_network.vnet,
  ]
}
