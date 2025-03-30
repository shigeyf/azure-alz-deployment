// customer_managed_key.tf

resource "azurerm_key_vault_key" "cmk" {
  name         = local.cmk_name
  key_vault_id = var.keyvault_id
  key_type     = var.key_policy.key_type
  key_size     = var.key_policy.key_size

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
      time_after_creation = var.key_policy.rotation_policy.automatic.time_after_creation
      time_before_expiry  = var.key_policy.rotation_policy.automatic.time_before_expiry
    }
    expire_after         = var.key_policy.rotation_policy.expire_after
    notify_before_expiry = var.key_policy.rotation_policy.notify_before_expiry
  }

  depends_on = [
    var.role_assignments
  ]
}
