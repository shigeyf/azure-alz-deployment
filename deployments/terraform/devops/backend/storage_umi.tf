// umi_storage.tf

// User Assigned Identity for Storage Account
resource "azurerm_user_assigned_identity" "storage_umi" {
  name                = local.storage_umi_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
