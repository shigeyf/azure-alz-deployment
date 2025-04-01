// private_endpoint.tf

resource "azurerm_private_endpoint" "storage" {
  name                = local.storage_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "storage-connection"
    private_connection_resource_id = azurerm_storage_account.storage.id
    is_manual_connection           = false
    subresource_names              = ["Blob"]
  }

  private_dns_zone_group {
    name                 = "storage-dns-zone-group"
    private_dns_zone_ids = var.private_dns_zone_ids
  }

  depends_on = [
    azurerm_storage_account.storage,
  ]
}
