// main.tf

module "vnet" {
  source              = "../../modules/private_vnet"
  naming_suffix       = var.naming_suffix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_base.name
  tags                = var.tags
  vnet_configs        = var.vnet_configs
}

module "keyvault" {
  source                     = "../../modules/private_keyvault"
  naming_suffix              = var.naming_suffix
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg_base.name
  tags                       = var.tags
  private_endpoint_subnet_id = module.vnet.private_vnet.subnet_ids[var.vnet_private_endpoints_subnet_index]
  role_assignments = [
    {
      principal_id         = var.terraform_service_principal_object_id
      role_definition_name = "Key Vault Administrator"
    },
    //{
    //  principal_id         = data.azurerm_client_config.current.object_id
    //  role_definition_name = "Key Vault Administrator"
    //}
  ]
}

module "storage" {
  source                     = "../../modules/private_storage"
  naming_suffix              = var.naming_suffix
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg_base.name
  tags                       = var.tags
  private_endpoint_subnet_id = module.vnet.private_vnet.subnet_ids[var.vnet_private_endpoints_subnet_index]
  keyvault_id                = module.keyvault.private_keyvault.keyvault_id
  role_assignments = [
    {
      principal_id         = var.terraform_service_principal_object_id
      role_definition_name = "Storage Blob Data Contributor"
    },
  ]
}
