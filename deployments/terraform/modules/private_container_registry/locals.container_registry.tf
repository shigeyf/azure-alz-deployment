// locals.container_registry.tf

locals {
  // Resource names
  container_registry_name    = module.naming.container_registry.name_unique
  container_registry_pe_name = module.naming.private_endpoint.name_unique
}
