// task.tf

resource "azurerm_container_registry_task" "this" {
  for_each              = var.images
  container_registry_id = azurerm_container_registry.this.id
  name                  = each.value.task_name
  tags                  = var.tags

  docker_step {
    context_access_token = each.value.context_access_token
    context_path         = each.value.context_path
    dockerfile_path      = each.value.dockerfile_path
    image_names          = each.value.image_names
  }

  platform {
    os = "Linux"
  }
  identity {
    type = "SystemAssigned" # Note this has to be a System Assigned Identity to work with private networking and `network_rule_bypass_option` set to `AzureServices`
  }
  registry_credential {
    custom {
      login_server = azurerm_container_registry.this.login_server
      identity     = "[system]"
    }
  }

  depends_on = [
    azurerm_container_registry.this,
  ]
}
