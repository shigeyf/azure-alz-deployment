// locals.keyvault.tf

// Resource names
locals {
  keyvault_name = module.naming.key_vault.short_name_unique
}
