// vm_password.tf

# Create KeyVault VM password
resource "random_password" "vm_password" {
  count   = var.vm_configs.options.password_enabled ? 1 : 0
  length  = local.vm_password_length
  special = true
}

# Create Key Vault Secret
resource "azurerm_key_vault_secret" "vm_password" {
  count        = (var.vm_secret_keyvault_id != null) && var.vm_configs.options.password_enabled ? 1 : 0
  name         = local.vm_password_name
  value        = random_password.vm_password[0].result
  key_vault_id = var.vm_secret_keyvault_id
}
