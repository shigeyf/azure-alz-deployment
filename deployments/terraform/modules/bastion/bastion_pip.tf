// bastion_pip.tf

# Create Public IP for Azure Bastion
resource "azurerm_public_ip" "bastion_pip" {
  name                = local.bastion_pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  allocation_method = local.public_ip_allocation_method
  sku               = local.public_ip_sku
}
