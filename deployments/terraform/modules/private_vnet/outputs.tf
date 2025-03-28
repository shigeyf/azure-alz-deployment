// outputs.tf

output "private_vnet" {
  value = {
    vnet_name  = azurerm_virtual_network.vnet.name
    vnet_id    = azurerm_virtual_network.vnet.id
    subnet_ids = { for key, subnet in azurerm_subnet.snet : key => subnet.id }
    nsg_ids    = { for key, nsg in azurerm_network_security_group.nsg : key => nsg.id }
  }
  description = "Ids for private_vnet module"
}
