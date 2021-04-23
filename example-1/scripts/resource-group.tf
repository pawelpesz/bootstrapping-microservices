resource "random_string" "resource_group_name" {
    length = 24
    special = false
    upper = false
}

locals {
    resource_group_name = substr(join("-", [var.app_name, random_string.resource_group_name.result]), 0, 24)
}

resource "azurerm_resource_group" "flixtube" {
    name     = local.resource_group_name
    location = var.location
}
