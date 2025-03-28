// lock.tf

resource "azurerm_management_lock" "keyvault" {
  count      = var.lock_enabled ? 1 : 0
  name       = "lock-${local.keyvault_name}"
  scope      = azurerm_key_vault.keyvault.id
  lock_level = "CanNotDelete"
  notes      = "Locked to prevent accidental deletion of the keyvault resource"

  depends_on = [
    azurerm_key_vault.keyvault,
  ]
}
