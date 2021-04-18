terraform {
    required_version = "~> 0.15"
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 1.44"
        }
        kubernetes = {
            source  = "hashicorp/kubernetes"
            version = ">= 2.1"
        }
        null = {
            source  = "hashicorp/null"
            version = ">= 3.1"
        }
        random = {
            source  = "hashicorp/random"
            version = ">= 3.0"
        }
        tls = {
            source  = "hashicorp/tls"
            version = ">= 3.1.0"
        }
    }
}