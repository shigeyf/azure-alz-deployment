// vm_windows.tf

resource "azurerm_windows_virtual_machine" "this" {
  count = var.vm_configs.os_type == local.vm_os_type_windows ? 1 : 0

  name                = local.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  size = var.vm_configs.size
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  admin_username = var.vm_configs.admin_username
  admin_password = random_password.this[0].result

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

  lifecycle {
    ignore_changes = [
      public_ip_address,
      public_ip_addresses,
    ]
  }
}
