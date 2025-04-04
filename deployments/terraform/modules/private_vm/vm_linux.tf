// vm_linux.tf

# Virtual Machine Linux
resource "azurerm_linux_virtual_machine" "this" {
  count = var.vm_configs.os_type == local.vm_os_type_linux ? 1 : 0

  name                = local.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  size = var.vm_configs.size
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  admin_username                  = var.vm_configs.admin_username
  disable_password_authentication = !var.vm_configs.options.password_enabled
  admin_password                  = var.vm_configs.options.password_enabled ? random_password.this[0].result : null
  dynamic "admin_ssh_key" {
    for_each = var.vm_configs.options.ssh_key_enabled ? [1] : []
    content {
      username   = var.vm_configs.admin_username
      public_key = azurerm_ssh_public_key.this[0].public_key
    }
  }

  // Default VM configurations
  bypass_platform_safety_checks_on_user_schedule_enabled = true
  encryption_at_host_enabled                             = false
  secure_boot_enabled                                    = false
  vtpm_enabled                                           = false
  patch_assessment_mode                                  = "AutomaticByPlatform"
  patch_mode                                             = "AutomaticByPlatform"

  additional_capabilities {
    hibernation_enabled = var.vm_configs.options.hibernation_enabled
  }

  disk_controller_type = "SCSI"
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
