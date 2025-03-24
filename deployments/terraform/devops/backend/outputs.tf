// outputs.tf

output "backend_resources" {
  value = {
    key_vault_id                  = azurerm_key_vault.key_vault.id
    key_vault_private_endpoint_id = var.deploy_private_endpoints ? azurerm_private_endpoint.key_vault_private_endpoint[0].id : null
    key_vault_storage_cmkey_id    = azurerm_key_vault_key.storage_cmkey.id
    storage_umi_id                = azurerm_user_assigned_identity.storage_umi.id
    storage_account_id            = azurerm_storage_account.tfbackend.id
    storage_private_endpoint_id   = var.deploy_private_endpoints ? azurerm_private_endpoint.storage_private_endpoint[0].id : null
  }
  description = "Ids for Backend resources"
}
