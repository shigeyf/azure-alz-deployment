// outputs.tf

output "devops_resources" {
  value = {
    resource_group_name = azurerm_resource_group.rg_base.name
    vnet_resources      = module.vnet.private_vnet
    keyvault_resources  = module.keyvault.private_keyvault
    storage_resources   = module.storage.private_storage
    private_dns_zones = {
      (azurerm_private_dns_zone.storage.name)  = azurerm_private_dns_zone.storage.id,
      (azurerm_private_dns_zone.keyvault.name) = azurerm_private_dns_zone.keyvault.id
    }
  }
}
