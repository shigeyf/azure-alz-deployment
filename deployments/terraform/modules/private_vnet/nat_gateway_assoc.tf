// nat_gateway_assoc.tf

resource "azurerm_subnet_nat_gateway_association" "this" {
  for_each       = var.vnet_configs.enable_nat_gateway ? azurerm_subnet.snet : {}
  subnet_id      = each.value.id
  nat_gateway_id = azurerm_nat_gateway.this[0].id

  depends_on = [
    azurerm_subnet.snet,
    azurerm_nat_gateway.this,
  ]
}
