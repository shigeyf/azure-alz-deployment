// terraform.tf

terraform {
  required_version = "~> 1.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    azapi = {
      source  = "azure/azapi"
      version = "~> 2.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0, < 4.0.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.1"
    }

    modtm = {
      source  = "azure/modtm"
      version = "~> 0.3"
    }
  }
}
