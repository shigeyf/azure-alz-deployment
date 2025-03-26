// keyvault.tf

// Key Vault resource
resource "azurerm_key_vault" "key_vault" {
  name                = local.keyvault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  tags                = var.tags

  enable_rbac_authorization       = true
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  public_network_access_enabled   = var.public_network_access_enabled
  purge_protection_enabled        = true
  soft_delete_retention_days      = 90
}

// "Key Vault Administrator" Role assignment for current user
resource "azurerm_role_assignment" "role_key_vault_admin_for_current_user" {
  scope                = azurerm_key_vault.key_vault.id
  principal_id         = data.azurerm_client_config.current.object_id
  role_definition_name = "Key Vault Administrator"

  depends_on = [
    azurerm_key_vault.key_vault,
  ]
}

// "Key Vault Crypto Officer" Role Assignment for User Assigned Identity for Storage Account
resource "azurerm_role_assignment" "role_key_vault_crypto_officer_for_umi" {
  scope                = azurerm_key_vault.key_vault.id
  principal_id         = azurerm_user_assigned_identity.storage_umi.principal_id
  role_definition_name = "Key Vault Crypto Officer"

  depends_on = [
    azurerm_key_vault.key_vault,
    azurerm_user_assigned_identity.storage_umi,
  ]
}

// Key Vault Key resource
resource "azurerm_key_vault_key" "storage_cmkey" {
  name         = local.storage_cmkey_name
  key_vault_id = azurerm_key_vault.key_vault.id
  key_type     = "RSA"
  key_size     = 4096

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }
    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }

  depends_on = [
    azurerm_key_vault.key_vault,
    azurerm_role_assignment.role_key_vault_admin_for_current_user,
  ]
}

// Private Endpoint for KeyVailt (optional)
resource "azurerm_private_endpoint" "key_vault_private_endpoint" {
  count               = var.deploy_private_endpoints ? 1 : 0
  name                = local.keyvault_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "keyvault-connection"
    private_connection_resource_id = azurerm_key_vault.key_vault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.tfbackend_kv_private_dns_zone.id]
  }

  depends_on = [
    azurerm_key_vault.key_vault,
    azurerm_private_dns_zone.tfbackend_kv_private_dns_zone,
  ]
}
