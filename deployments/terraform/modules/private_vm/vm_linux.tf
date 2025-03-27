// vm_linux.tf

# Virtual Machine Linux
resource "azurerm_linux_virtual_machine" "vm" {
  count = var.vm_configs.os_type == local.vm_os_type_linux ? 1 : 0

  name                = local.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  size = var.vm_configs.size
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  admin_username                  = var.vm_configs.admin_username
  disable_password_authentication = !var.vm_configs.options.password_enabled
  admin_password                  = var.vm_configs.options.password_enabled ? random_password.vm_password[0].result : null
  dynamic "admin_ssh_key" {
    for_each = var.vm_configs.options.ssh_key_enabled ? [1] : []
    content {
      username   = var.vm_configs.admin_username
      public_key = azurerm_ssh_public_key.vm_ssh_key[0].public_key
    }
  }

  additional_capabilities {
    hibernation_enabled = var.vm_configs.options.hibernation_enabled
  }

  os_disk {
    disk_size_gb         = var.vm_configs.os_disk_size
    storage_account_type = var.vm_configs.os_disk_type
    caching              = "ReadWrite"
  }

  source_image_reference {
    publisher = var.vm_configs.os_source_image.publisher
    offer     = var.vm_configs.os_source_image.offer
    sku       = var.vm_configs.os_source_image.sku
    version   = var.vm_configs.os_source_image.version
  }
}
