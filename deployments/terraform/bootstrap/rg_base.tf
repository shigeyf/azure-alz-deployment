// rg.tf

resource "azurerm_resource_group" "rg_base" {
  name     = module.naming.resource_group.name
  location = var.location
  tags     = var.tags
}
