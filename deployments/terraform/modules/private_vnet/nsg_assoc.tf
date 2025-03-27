// ngs_assoc.tf

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each = var.vnet_configs.subnets

  subnet_id                 = azurerm_subnet.snet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id

  depends_on = [
    azurerm_virtual_network.vnet,
    azurerm_subnet.snet,
    azurerm_network_security_group.nsg,
  ]
}
