// outputs.tf

output "bootstrap_resources" {
  value = {
    resource_group_id = azurerm_resource_group.rg_base.id
    keyvault_id       = module.keyvault.public_keyvault_id
    vnet_resources    = module.vnet.private_vnet
  }
  description = "Ids for Bootstrap resources"
}

output "devops_resources" {
  value       = module.devops.devops_resources
  description = "Ids for DevOps resources"
}
