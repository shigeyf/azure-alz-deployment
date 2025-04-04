// task_schedule_run_now.tf

resource "azurerm_container_registry_task_schedule_run_now" "this" {
  for_each                   = var.images
  container_registry_task_id = azurerm_container_registry_task.this[each.key].id
  lifecycle {
    replace_triggered_by = [azurerm_container_registry_task.this]
  }

  depends_on = [
    azurerm_container_registry_task.this,
  ]
}
