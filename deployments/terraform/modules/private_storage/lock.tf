// lock.tf

resource "azurerm_management_lock" "storage" {
  count      = var.lock_enabled ? 1 : 0
  name       = "lock-${local.storage_account_name}"
  scope      = azurerm_storage_account.storage.id
  lock_level = "CanNotDelete"
  notes      = "Locked to prevent accidental deletion of the storage resource"

  depends_on = [
    azurerm_storage_account.storage,
  ]
}
