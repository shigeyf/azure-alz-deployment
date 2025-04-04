// storage.tf

resource "azurerm_storage_account" "this" {
  name                = local.storage_account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  account_kind                    = "StorageV2"
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  nfsv3_enabled                   = false
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false
  public_network_access_enabled   = false

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.this.id,
    ]
  }

  depends_on = [
    azurerm_user_assigned_identity.this,
  ]
}
