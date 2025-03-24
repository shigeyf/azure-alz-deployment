// ngs_assoc.tf

#
# NSG associations
#

resource "azurerm_subnet_network_security_group_association" "bastion_nsg_assoc" {
  count                     = var.deploy_network ? 1 : 0
  subnet_id                 = azurerm_subnet.azure_bastion.id
  network_security_group_id = azurerm_network_security_group.bastion_nsg[0].id

  depends_on = [
    azurerm_virtual_network.vnet,
    azurerm_network_security_group.bastion_nsg,
  ]
}

resource "azurerm_subnet_network_security_group_association" "jumpbox_nsg_assoc" {
  count                     = var.deploy_network ? 1 : 0
  subnet_id                 = azurerm_subnet.jumpbox.id
  network_security_group_id = azurerm_network_security_group.jumpbox_nsg[0].id

  depends_on = [
    azurerm_virtual_network.vnet,
    azurerm_network_security_group.jumpbox_nsg,
  ]
}

resource "azurerm_subnet_network_security_group_association" "private_endpoints_nsg_assoc" {
  count                     = var.deploy_network ? 1 : 0
  subnet_id                 = azurerm_subnet.private_endpoints.id
  network_security_group_id = azurerm_network_security_group.private_endpoints_nsg[0].id

  depends_on = [
    azurerm_virtual_network.vnet,
    azurerm_network_security_group.private_endpoints_nsg,
  ]
}
