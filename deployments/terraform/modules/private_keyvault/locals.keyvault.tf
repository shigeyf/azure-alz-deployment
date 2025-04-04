// locals.keyvault.tf

locals {
  // Resource names
  keyvault_name    = module.naming.key_vault.short_name_unique
  keyvault_pe_name = join("-", [module.naming.private_endpoint.name_unique_with_pad, local.keyvault_name])
}
