// locals.storage.tf

locals {
  // Resource names
  storage_account_name = module.naming.storage_account.short_name_unique
  storage_umi_name     = module.naming.user_assigned_identity.name_unique
  storage_pe_name      = join("-", [module.naming.private_endpoint.name_unique_with_pad, local.storage_account_name])
}
