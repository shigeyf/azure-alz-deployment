// outputs.tf

output "public_keyvault_id" {
  value = azurerm_key_vault.key_vault.id
}

output "public_keyvault_role_assignment" {
  value = azurerm_role_assignment.key_vault_admin_for_current_user
}
