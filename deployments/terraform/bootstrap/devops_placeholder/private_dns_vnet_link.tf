// private_dns_vnet_link.tf

resource "azurerm_private_dns_zone_virtual_network_link" "storage" {
  name                  = "vnet-link-${module.vnet.private_vnet.vnet_name}"
  resource_group_name   = azurerm_resource_group.rg_base.name
  tags                  = var.tags
  private_dns_zone_name = azurerm_private_dns_zone.storage.name
  virtual_network_id    = module.vnet.private_vnet.vnet_id

  depends_on = [
    azurerm_private_dns_zone.storage
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "keyvault" {
  name                  = "vnet-link-${module.vnet.private_vnet.vnet_name}"
  resource_group_name   = azurerm_resource_group.rg_base.name
  tags                  = var.tags
  private_dns_zone_name = azurerm_private_dns_zone.keyvault.name
  virtual_network_id    = module.vnet.private_vnet.vnet_id

  depends_on = [
    azurerm_private_dns_zone.keyvault
  ]
}
