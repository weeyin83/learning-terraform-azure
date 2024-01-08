##
# Terraform Configuration
##

terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.6.0"
    }
  }
    backend "remote" {
    hostname = "backend.api.env0.com"
    organization = "1ac843c4-9b54-4173-8633-0b179ec1c125"
    
    workspaces {
      name = "learning-terraform-azure-infrastructure-75602104"
    }
  }
}

## 
# Provider configuration
##
provider "azurerm" {
  features {}
}

provider "random" {
  # Configuration options
}


