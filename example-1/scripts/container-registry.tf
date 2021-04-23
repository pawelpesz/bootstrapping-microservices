resource "random_string" "container_registry_name" {
    length = 24
    special = false
    upper = false
}

locals {
    container_registry_name = substr(join("", [var.app_name, random_string.container_registry_name.result]), 0, 24)
}

resource "azurerm_container_registry" "container_registry" {
    name                = local.container_registry_name
    resource_group_name = azurerm_resource_group.flixtube.name
    location            = var.location
    admin_enabled       = true
    sku                 = "Basic"
}

output "registry_hostname" {
    value = azurerm_container_registry.container_registry.login_server
}

output "registry_un" {
    value = azurerm_container_registry.container_registry.admin_username
}

output "registry_pw" {
    value = azurerm_container_registry.container_registry.admin_password
    sensitive = true
}
