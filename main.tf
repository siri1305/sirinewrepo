terraform {
 required_providers {
  azurerm = {
   source = "hashicorp/azurerm"
   version = "4.41.0"
  }
 }
}

provider "azurerm" {
features {}
subscription_id = "5fbead97-423e-4814-809c-114db991d911"
}

resource "azurerm_resource_group" "rg1" {
 name = "rz1"
 location = "west us"
 }

resource "azurerm_resource_group" "rg2" {
 name = "rz2"
 location = "east us"
 }
