// outputs.tf

output "private_keyvault" {
  value = {
    keyvault_id    = azurerm_key_vault.keyvault.id
    keyvault_pe_id = azurerm_private_endpoint.keyvault.id
  }
  description = "Ids for KeyVault resources"
}
