// role_assignment.tf

resource "azurerm_role_assignment" "ra" {
  for_each = { for index, ra in var.role_assignments : index => ra }

  scope                = azurerm_key_vault.this.id
  principal_id         = each.value.principal_id
  role_definition_name = each.value.role_definition_name

  depends_on = [
    azurerm_key_vault.this,
  ]
}

# This resource is used to ensure that the role assignment is created after the Key Vault is created.
resource "time_sleep" "wait_for_propagation" {
  create_duration = "120s"
  depends_on = [
    azurerm_role_assignment.ra,
  ]
}
