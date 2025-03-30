// outputs.tf

output "devops_resources" {
  value = {
    vnet_resources     = module.vnet.private_vnet
    keyvault_resources = module.keyvault.private_keyvault
    storage_resources  = module.storage.private_storage
  }
}
