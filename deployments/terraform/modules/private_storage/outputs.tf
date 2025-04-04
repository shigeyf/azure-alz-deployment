// outputs.tf

output "private_storage" {
  value = {
    storage_id     = azurerm_storage_account.this.id
    storage_uai_id = azurerm_user_assigned_identity.this.id
    storage_pe_id  = azurerm_private_endpoint.this.id
  }
  description = "Ids for Storage resources"
}
