terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }


}
provider "azurerm" {
  features {}
  subscription_id = "6da16843-2652-4f6e-b550-b4d1a16b30a9"
}