// private_endpoint.tf

resource "azurerm_private_endpoint" "this" {
  name                = local.keyvault_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "keyvault-connection"
    private_connection_resource_id = azurerm_key_vault.this.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "keyvault-dns-zone-group"
    private_dns_zone_ids = var.private_dns_zone_ids
  }

  depends_on = [
    azurerm_key_vault.this,
    time_sleep.wait_for_propagation,
  ]
}
