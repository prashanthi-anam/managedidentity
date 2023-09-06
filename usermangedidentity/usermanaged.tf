terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.49.0"
    }
  }
}
module "managedidentity" {
  source               = "./module"
  resourcegroup         = "rg1"
  location             = "East Us"
  
}