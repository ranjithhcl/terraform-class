# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.1.0"
    }
  }

  required_version = ">= 1.1.0"
}

### Comment this block for first time setup.
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "rg-testing"
#     storage_account_name = "stamystoragevo9mfk"  ## Note: This might change as per storageaccount name
#     container_name       = "tfstate"
#     key                  = "terraform.tfstate"
#   }
# }

provider "azurerm" {
  features {}
}

module "storage" {
  source  = "kumarvna/storage/azurerm"
  version = "2.5.0"

  create_resource_group             = true
  resource_group_name               = "rg-testing"
  location                          = "westeurope"
  storage_account_name              = "mystorage"
  enable_advanced_threat_protection = true
  containers_list = [
    { name = "tfstate", access_type = "blob" }
  ]
  lifecycles = [
    {
      prefix_match               = ["tfstate/tfstate_path"]
      tier_to_cool_after_days    = 0
      tier_to_archive_after_days = 10
      delete_after_days          = 25
      snapshot_delete_after_days = 10
    }
  ]

  network_rules = {
    bypass     = ["AzureServices"]
    ip_rules   = ["122.172.80.61"]
    subnet_ids = []
  }
  tags = {
    ProjectName  = "demo-internal"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}
