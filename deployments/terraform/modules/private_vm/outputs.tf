// outputs.tf

output "private_vm" {
  value = {
    vm_linux_id   = var.vm_configs.os_type == local.vm_os_type_linux ? azurerm_linux_virtual_machine.this[0].id : null
    vm_windows_id = var.vm_configs.os_type == local.vm_os_type_windows ? azurerm_windows_virtual_machine.this[0].id : null
    vm_nic_id     = azurerm_network_interface.this.id
  }
  description = "Ids for VM resources"
}
