// outputs.tf

locals {
  merged_outputs = merge(module.network.network_resources, module.backend_storage.backend_resources, module.jumpstart.jumpstart_resources)
}

output "devops_resources" {
  value       = local.merged_outputs
  description = "Ids for DevOps resources"
}

output "resource_group_id" {
  value       = var.use_existing_rg ? data.azurerm_resource_group.existing_rg_base[0].id : azurerm_resource_group.rg_base[0].id
  description = "Id of the resource group"
}
