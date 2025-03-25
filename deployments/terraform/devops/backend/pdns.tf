// pdns.tf

# Create private DNS zone
resource "azurerm_private_dns_zone" "tfbackend_st_private_dns_zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone" "tfbackend_kv_private_dns_zone" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Create virtual network link
resource "azurerm_private_dns_zone_virtual_network_link" "tfbackend_st_private_dns_vnet_link" {
  name                = "st-vnet-link"
  resource_group_name = var.resource_group_name
  tags                = var.tags

  private_dns_zone_name = azurerm_private_dns_zone.tfbackend_st_private_dns_zone.name
  virtual_network_id    = var.virtual_network_id
}

resource "azurerm_private_dns_zone_virtual_network_link" "tfbackend_kv_private_dns_vnet_link" {
  name                = "kv-vnet-link"
  resource_group_name = var.resource_group_name
  tags                = var.tags

  private_dns_zone_name = azurerm_private_dns_zone.tfbackend_kv_private_dns_zone.name
  virtual_network_id    = var.virtual_network_id
}
