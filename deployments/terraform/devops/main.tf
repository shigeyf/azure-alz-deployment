// main.tf

resource "azurerm_resource_group" "rg_base" {
  count    = var.use_existing_rg ? 0 : 1
  name     = var.use_existing_rg ? var.existing_rg_name : module.naming.resource_group.name
  location = var.location
  tags     = var.tags
}

data "azurerm_resource_group" "existing_rg_base" {
  count = var.use_existing_rg ? 1 : 0
  name  = var.existing_rg_name
}

module "network" {
  source              = "./network"
  naming_conventions  = local.naming_conventions
  location            = var.location
  tags                = var.tags
  resource_group_name = var.use_existing_rg ? data.azurerm_resource_group.existing_rg_base[0].name : azurerm_resource_group.rg_base[0].name

  deploy_network = var.deploy_network
  network        = var.network
}

module "backend_storage" {
  source              = "./backend"
  naming_conventions  = local.naming_conventions
  location            = var.location
  resource_group_name = var.use_existing_rg ? data.azurerm_resource_group.existing_rg_base[0].name : azurerm_resource_group.rg_base[0].name
  tags                = var.tags

  public_network_access_enabled = var.initial_deploy_via_public
  deploy_private_endpoints      = var.deploy_private_endpoints
  virtual_network_id            = module.network.network_resources.vnet_id
  private_endpoint_subnet_id    = module.network.network_resources.private_endpoints_subnet_id
}

module "jumpstart" {
  source              = "./jumpstart"
  naming_conventions  = local.naming_conventions
  location            = var.location
  tags                = var.tags
  resource_group_name = var.use_existing_rg ? data.azurerm_resource_group.existing_rg_base[0].name : azurerm_resource_group.rg_base[0].name

  virtual_machine = {
    vm_admin_user          = var.virtual_machine.vm_admin_user
    vm_admin_ssh_key       = file(var.virtual_machine.vm_admin_ssh_key_file)
    vm_bastion_sku         = var.virtual_machine.vm_bastion_sku
    vm_hibernation_enabled = var.virtual_machine.vm_hibernation_enabled
    vm_os_windows          = var.virtual_machine.vm_os_windows
    vm_os_disk_size        = var.virtual_machine.vm_os_disk_size
    vm_os_disk_type        = var.virtual_machine.vm_os_disk_type
    vm_password_kv_id      = module.backend_storage.backend_resources.key_vault_id
    vm_size                = var.virtual_machine.vm_size
    vm_subnet_id           = module.network.network_resources.jumpbox_subnet_id
    bastion_subnet_id      = module.network.network_resources.bastion_subnet_id
  }
}
