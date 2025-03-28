// private_endpoint.tf

resource "azurerm_private_endpoint" "keyvault" {
  name                = local.keyvault_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "keyvault-connection"
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  depends_on = [
    azurerm_key_vault.keyvault,
    time_sleep.wait_for_propagation,
  ]
}
