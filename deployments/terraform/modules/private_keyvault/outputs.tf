// outputs.tf

output "private_keyvault" {
  value = {
    keyvault_id      = azurerm_key_vault.this.id
    keyvault_pe_id   = azurerm_private_endpoint.this.id,
    role_assignments = azurerm_role_assignment.ra,
  }
  description = "Ids for KeyVault resources"
}
