// vm.tf

# Network Interface
resource "azurerm_network_interface" "vm_nic" {
  name                = local.vm_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.virtual_machine.vm_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

# Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = local.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  size = var.virtual_machine.vm_size
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  admin_username                  = var.virtual_machine.vm_admin_user
  disable_password_authentication = true
  admin_ssh_key {
    username   = var.virtual_machine.vm_admin_user
    public_key = var.virtual_machine.vm_admin_ssh_key
  }

  additional_capabilities {
    hibernation_enabled = var.virtual_machine.vm_hibernation_enabled
  }

  os_disk {
    //name                 = local.vm_os_disk_name
    disk_size_gb         = var.virtual_machine.vm_os_disk_size
    caching              = "ReadWrite"
    storage_account_type = var.virtual_machine.vm_os_disk_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
