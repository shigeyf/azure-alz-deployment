// outputs.tf

output "jumpstart_resources" {
  value = {
    vm_id          = azurerm_linux_virtual_machine.vm.id
    vm_nic_id      = azurerm_network_interface.vm_nic.id
    bastion_id     = azurerm_bastion_host.bastion.id
    bastion_pip_id = azurerm_public_ip.bastion_pip.id
  }
  description = "Ids for JumpStart resources"
}
