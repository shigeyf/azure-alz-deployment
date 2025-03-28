// outputs.tf

output "private_storage" {
  value = {
    storage_id     = azurerm_storage_account.storage.id
    storage_umi_id = azurerm_user_assigned_identity.storage.id
    storage_pe_id  = azurerm_private_endpoint.storage.id
  }
  description = "Ids for Storage resources"
}
