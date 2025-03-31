// container.tf

resource "azurerm_storage_container" "container" {
  for_each = { for index, container in var.containers : index => container }

  name                  = each.value.name
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = each.value.container_access_type

  depends_on = [
    azurerm_storage_account.storage,
  ]
}
