// outputs.tf

output "network_resources" {
  value = {
    vnet_id                         = var.deploy_network ? azurerm_virtual_network.vnet[0].id : null
    bastion_subnet_id               = var.deploy_network ? azurerm_subnet.azure_bastion.id : null
    jumpbox_subnet_id               = var.deploy_network ? azurerm_subnet.jumpbox.id : null
    private_endpoints_subnet_id     = var.deploy_network ? azurerm_subnet.private_endpoints.id : null
    bastion_subnet_nsg_id           = var.deploy_network ? azurerm_network_security_group.bastion_nsg[0].id : null
    jumpbox_subnet_nsg_id           = var.deploy_network ? azurerm_network_security_group.jumpbox_nsg[0].id : null
    private_endpoints_subnet_nsg_id = var.deploy_network ? azurerm_network_security_group.private_endpoints_nsg[0].id : null
  }
  description = "Ids for Network resources"
}
