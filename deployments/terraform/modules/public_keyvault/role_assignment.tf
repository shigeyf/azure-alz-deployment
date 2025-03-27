//

// "Key Vault Administrator" Role assignment for current user
resource "azurerm_role_assignment" "key_vault_admin_for_current_user" {
  scope                = azurerm_key_vault.key_vault.id
  principal_id         = data.azurerm_client_config.current.object_id
  role_definition_name = "Key Vault Administrator"

  depends_on = [
    azurerm_key_vault.key_vault,
  ]
}
