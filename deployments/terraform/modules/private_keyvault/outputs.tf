// outputs.tf

output "private_keyvault" {
  value = {
    keyvault_id = azurerm_key_vault.key_vault.id
  }
  description = "Ids for KeyVault resources"
}
