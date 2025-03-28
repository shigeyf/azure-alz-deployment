// storage_umi.tf

// User Assigned Identity for Storage account
resource "azurerm_user_assigned_identity" "storage" {
  name                = local.storage_umi_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
