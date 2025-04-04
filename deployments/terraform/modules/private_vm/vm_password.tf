// vm_password.tf

# Create KeyVault VM password
resource "random_password" "this" {
  count   = var.vm_configs.options.password_enabled ? 1 : 0
  length  = local.vm_password_length
  special = true
}

# Create Key Vault Secret
resource "azurerm_key_vault_secret" "this_password" {
  count        = var.vm_secret_keyvault_enabled && var.vm_configs.options.password_enabled ? 1 : 0
  name         = local.vm_password_name
  value        = random_password.this[0].result
  key_vault_id = var.vm_secret_keyvault_id

  depends_on = [
    var.vm_secret_role_assignment,
  ]
}
