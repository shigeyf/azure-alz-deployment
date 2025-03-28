// vm_ssh_key.tf

# ED25519 key for SSH authentication
resource "tls_private_key" "ssh_key" {
  count = (var.vm_configs.os_type == local.vm_os_type_linux) && var.vm_configs.options.ssh_key_enabled ? 1 : 0

  algorithm = "ED25519"
}

resource "azurerm_ssh_public_key" "vm_ssh_key" {
  count = (var.vm_configs.os_type == local.vm_os_type_linux) && var.vm_configs.options.ssh_key_enabled ? 1 : 0

  name                = local.vm_ssh_key_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  public_key = tls_private_key.ssh_key[0].public_key_openssh
}

resource "local_sensitive_file" "pem_file" {
  count = (var.vm_configs.os_type == local.vm_os_type_linux) && var.vm_configs.options.ssh_key_enabled ? 1 : 0

  content              = tls_private_key.ssh_key[0].private_key_openssh
  filename             = pathexpand(var.ssh_private_key_filepath)
  file_permission      = "0600"
  directory_permission = "0700"
}

resource "azurerm_key_vault_secret" "vm_ssh_key" {
  count = var.vm_secret_keyvault_enabled && (var.vm_configs.os_type == local.vm_os_type_linux) && var.vm_configs.options.ssh_key_enabled ? 1 : 0

  name         = local.vm_ssh_key_name
  value        = tls_private_key.ssh_key[0].public_key_openssh
  key_vault_id = var.vm_secret_keyvault_id
}
