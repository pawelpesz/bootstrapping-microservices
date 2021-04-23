resource "random_string" "storage_account_name" {
    length = 24
    special = false
    upper = false
}

locals {
    storage_account_name = substr(join("", [var.app_name, random_string.storage_account_name.result]), 0, 24)
}

resource "azurerm_storage_account" "flixtube" {
    name                     = local.storage_account_name
    resource_group_name      = azurerm_resource_group.flixtube.name
    location                 = azurerm_resource_group.flixtube.location
    account_tier             = "Standard"
    account_replication_type = "GRS"
}