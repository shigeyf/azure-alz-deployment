// kv_role_assignment.tf

resource "azurerm_role_assignment" "key_vault_crypto_officer_for_storage_umi" {
  scope                = var.keyvault_id
  principal_id         = azurerm_user_assigned_identity.storage.principal_id
  role_definition_name = "Key Vault Crypto Officer"

  depends_on = [
    azurerm_user_assigned_identity.storage,
  ]
}
