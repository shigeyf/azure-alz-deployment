// kv_role_assignment.tf

resource "azurerm_role_assignment" "ra_key_vault_crypto_officer" {
  scope                = var.keyvault_id
  principal_id         = azurerm_user_assigned_identity.this.principal_id
  role_definition_name = local.role_name_key_vault_crypto_officer

  depends_on = [
    azurerm_user_assigned_identity.this,
  ]
}
