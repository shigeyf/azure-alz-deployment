// main.tf

module "keyvault" {
  source              = "../modules/public_keyvault"
  naming_suffix       = var.naming_suffix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_base.name
  tags                = var.tags
}

module "vnet" {
  source              = "../modules/private_vnet"
  naming_suffix       = var.naming_suffix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_base.name
  tags                = var.tags

  vnet_configs = var.vnet_configs
}

module "vm" {
  source              = "../modules/private_vm"
  naming_suffix       = var.naming_suffix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_base.name
  tags                = var.tags

  ssh_private_key_filepath   = var.ssh_private_key_filepath
  vm_secret_keyvault_id      = module.keyvault.public_keyvault_id
  vm_secret_keyvault_enabled = true
  vm_secret_role_assignment  = module.keyvault.public_keyvault_role_assignment

  vm_configs = merge(var.vm_configs, {
    nic_subnet_id = module.vnet.private_vnet.subnet_ids[var.vnet_vm_subnet_index]
  })
}

module "bastion" {
  source              = "../modules/bastion"
  naming_suffix       = var.naming_suffix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_base.name
  tags                = var.tags

  bastion_configs = {
    sku         = var.bastion_configs.sku
    scale_units = var.bastion_configs.scale_units
    subnet_id   = module.vnet.private_vnet.subnet_ids[var.vnet_bastion_subnet_index]
  }
}

module "devops" {
  source                                = "./devops_placeholder"
  naming_suffix                         = var.devops_naming_suffix
  location                              = var.location
  tags                                  = var.devops_tags
  vnet_private_endpoints_subnet_index   = var.devops_vnet_private_endpoints_subnet_index
  vnet_configs                          = var.devops_vnet_configs
  terraform_service_principal_object_id = var.terraform_service_principal_object_id
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  for_each              = module.devops.devops_resources.private_dns_zones
  name                  = "vnet-link-${module.vnet.private_vnet.vnet_name}"
  resource_group_name   = module.devops.devops_resources.resource_group_name
  tags                  = var.tags
  private_dns_zone_name = each.key
  virtual_network_id    = module.vnet.private_vnet.vnet_id
}

module "vnet_peering" {
  source = "../modules/vnet_peering"
  peering_pairs = [
    {
      to = {
        name                     = "bootstrap"
        vnet_resource_group_name = azurerm_resource_group.rg_base.name
        vnet_id                  = module.vnet.private_vnet.vnet_id
        vnet_name                = module.vnet.private_vnet.vnet_name
        options = {
          allow_virtual_network_access = true
          allow_forwarded_traffic      = true
          allow_gateway_transit        = false
          use_remote_gateways          = false
        }
      }
      from = {
        name                     = "devops"
        vnet_resource_group_name = module.devops.devops_resources.resource_group_name
        vnet_id                  = module.devops.devops_resources.vnet_resources.vnet_id
        vnet_name                = module.devops.devops_resources.vnet_resources.vnet_name
        options = {
          allow_virtual_network_access = true
          allow_forwarded_traffic      = true
          allow_gateway_transit        = false
          use_remote_gateways          = false
        }
      }
    }
  ]
}
