// bastion.tf

# Create Azure Bastion Host
resource "azurerm_bastion_host" "bastion" {
  name                = local.bastion_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.bastion_configs.subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }

  copy_paste_enabled = true
  scale_units        = var.bastion_configs.scale_units
  sku                = var.bastion_configs.sku
  tunneling_enabled  = true

  depends_on = [
    azurerm_public_ip.bastion_pip
  ]
}
