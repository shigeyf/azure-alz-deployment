// role_assignment.tf

resource "azurerm_role_assignment" "ra" {
  for_each = { for index, ra in var.role_assignments : index => ra }

  scope                = azurerm_key_vault.key_vault.id
  principal_id         = each.value.principal_id
  role_definition_name = each.value.role_definition_name

  depends_on = [
    azurerm_key_vault.key_vault,
  ]
}
