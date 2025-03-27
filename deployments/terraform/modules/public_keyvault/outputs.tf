// outputs.tf

output "public_keyvault_id" {
  value = azurerm_key_vault.key_vault.id
}
