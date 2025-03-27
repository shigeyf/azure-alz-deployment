// outputs.tf

output "bastion" {
  value = {
    bastion_host_id = azurerm_bastion_host.bastion.id
    bastion_pip_id  = azurerm_public_ip.bastion_pip.id
  }
  description = "Ids for Bastion Host resources"
}
