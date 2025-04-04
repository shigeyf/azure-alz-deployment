// container_registry.tf

resource "azurerm_container_registry" "this" {
  name                          = local.container_registry_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = "Premium"
  public_network_access_enabled = false
  zone_redundancy_enabled       = false
  network_rule_bypass_option    = "AzureServices"
}
