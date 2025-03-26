// vmpassword.tf

# Create KeyVault VM password
resource "random_password" "vmpassword" {
  length  = 20
  special = true
}

# Create Key Vault Secret
resource "azurerm_key_vault_secret" "vmpassword" {
  name         = local.vm_password_name
  value        = random_password.vmpassword.result
  key_vault_id = var.virtual_machine.vm_password_kv_id
}
