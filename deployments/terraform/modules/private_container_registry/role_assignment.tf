// role_assignment.tf

resource "azurerm_role_assignment" "ra_acr_pull_for_container_compute" {
  principal_id         = var.container_compute_managed_identity_principal_id
  scope                = azurerm_container_registry.this.id
  role_definition_name = "AcrPull"

  depends_on = [
    azurerm_container_registry.this,
  ]
}

resource "azurerm_role_assignment" "ra_acr_push_for_task" {
  for_each             = var.images
  principal_id         = azurerm_container_registry_task.this[each.key].identity[0].principal_id
  scope                = azurerm_container_registry.this.id
  role_definition_name = "AcrPush"

  depends_on = [
    azurerm_container_registry.this,
    azurerm_container_registry_task.this,
  ]
}
