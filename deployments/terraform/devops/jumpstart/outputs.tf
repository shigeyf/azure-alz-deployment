// outputs.tf

output "jumpstart_resources" {
  value = {
    vm_id          = var.virtual_machine.vm_os_windows ? azurerm_windows_virtual_machine.jumpbox_vm[0].id : azurerm_linux_virtual_machine.jumpbox_vm[0].id
    vm_nic_id      = azurerm_network_interface.vm_nic.id
    bastion_id     = azurerm_bastion_host.bastion.id
    bastion_pip_id = azurerm_public_ip.bastion_pip.id
  }
  description = "Ids for JumpStart resources"
}
