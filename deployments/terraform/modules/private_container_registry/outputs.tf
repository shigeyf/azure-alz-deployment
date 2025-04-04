// outputs.tf

output "container_registry" {
  value = azurerm_container_registry.this
}

output "container_registry_private_endpoint" {
  value = azurerm_private_endpoint.this.id
}
