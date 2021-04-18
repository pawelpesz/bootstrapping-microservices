resource "random_string" "random" {
    length = 24
    special = false
    upper = false
}

locals {
    storage_name = substr(join("-", [var.app_name, random_string.random.result]), 0, 24)
}


resource "azurerm_storage_account" "flixtube" {
    name                     = local.storage_name
    resource_group_name      = azurerm_resource_group.flixtube.name
    location                 = azurerm_resource_group.flixtube.location
    account_tier             = "Standard"
    account_replication_type = "GRS"
}