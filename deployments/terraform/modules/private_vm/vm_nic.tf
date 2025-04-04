// vm_nic.tf

# Network Interface
resource "azurerm_network_interface" "this" {
  name                = local.vm_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.vm_configs.nic_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}
