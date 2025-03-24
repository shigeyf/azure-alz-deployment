// storage.tf

// Storage account resource
resource "azurerm_storage_account" "tfbackend" {
  name                = local.storage_account_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  account_kind                    = "StorageV2"
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  nfsv3_enabled                   = false
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false
  public_network_access_enabled   = true

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.storage_umi.id,
    ]
  }

  customer_managed_key {
    key_vault_key_id = azurerm_key_vault_key.storage_cmkey.versionless_id
    // Do not add key version in the key_id here, it will be automatically set to the latest version of the key
    user_assigned_identity_id = azurerm_user_assigned_identity.storage_umi.id
  }

  depends_on = [
    azurerm_user_assigned_identity.storage_umi,
    azurerm_key_vault.key_vault,
    azurerm_key_vault_key.storage_cmkey,
    azurerm_role_assignment.role_key_vault_crypto_officer_for_umi,
  ]
}

// Resource Lock for Storage account
resource "azurerm_management_lock" "tfbackend-storage" {
  name       = "tfbackend-storage-lock"
  scope      = azurerm_storage_account.tfbackend.id
  lock_level = "CanNotDelete"
  notes      = "Locked to prevent accidental deletion of the storage account"

  depends_on = [
    azurerm_storage_account.tfbackend,
  ]
}

// A Container resource in the Storage account
resource "azurerm_storage_container" "tfbackend-container" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfbackend.id
  container_access_type = "private"

  depends_on = [
    azurerm_storage_account.tfbackend,
  ]
}

// Private Endpoint for Storage (optional)
resource "azurerm_private_endpoint" "storage_private_endpoint" {
  count               = var.deploy_private_endpoints ? 1 : 0
  name                = local.storage_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "storage-connection"
    private_connection_resource_id = azurerm_storage_account.tfbackend.id
    is_manual_connection           = false
    subresource_names              = ["Blob"]
  }

  depends_on = [
    azurerm_storage_account.tfbackend,
  ]
}
