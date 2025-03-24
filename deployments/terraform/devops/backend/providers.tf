// provider.tf

provider "azurerm" {
  storage_use_azuread = true

  features {
    key_vault {
      purge_soft_deleted_keys_on_destroy = true
      recover_soft_deleted_keys          = true
    }
  }
}
