// bastion.tf

# Create Public IP for Azure Bastion
resource "azurerm_public_ip" "bastion_pip" {
  name                = local.bastion_pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  allocation_method = "Static"
  sku               = "Standard"
}

# Create Azure Bastion Host
resource "azurerm_bastion_host" "bastion" {
  name                = local.bastion_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.virtual_machine.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }

  copy_paste_enabled = true
  scale_units        = 2
  sku                = var.virtual_machine.vm_bastion_sku
  tunneling_enabled  = true
}
