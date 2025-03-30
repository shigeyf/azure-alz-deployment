// outputs.tf

output "customer_managed_key" {
  value       = cmk.id
  description = "Ids for Customer Managed Key"
}
