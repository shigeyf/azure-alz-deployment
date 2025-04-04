// outputs.tf

output "private_vnet" {
  value = {
    vnet_name     = azurerm_virtual_network.vnet.name
    vnet_id       = azurerm_virtual_network.vnet.id
    subnet_ids    = { for key, subnet in azurerm_subnet.snet : key => subnet.id }
    nsg_ids       = { for key, nsg in azurerm_network_security_group.nsg : key => nsg.id }
    natgw_name    = var.vnet_configs.enable_nat_gateway ? azurerm_nat_gateway.this[0].name : null
    natgw_ip_name = var.vnet_configs.enable_nat_gateway ? azurerm_public_ip.this[0].name : null
  }
  description = "Ids for private_vnet module"
}
