// locals.nat_gateway.tf

// Resource names
locals {
  nat_gateway_public_ip_name = module.naming.public_ip.name_unique
  nat_gateway_name           = module.naming.nat_gateway.name_unique
}
