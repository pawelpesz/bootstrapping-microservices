resource "random_string" "cluster_name" {
    length = 24
    special = false
    upper = false
}

locals {
    cluster_name = substr(join("-", [var.app_name, random_string.cluster_name.result]), 0, 24)
}

resource "azurerm_kubernetes_cluster" "cluster" {
    name                = local.cluster_name
    location            = var.location
    resource_group_name = azurerm_resource_group.flixtube.name
    dns_prefix          = local.cluster_name
    kubernetes_version  = "1.20.5"

    linux_profile {
        admin_username = var.admin_username

        ssh_key {
            key_data = "${trimspace(tls_private_key.key.public_key_openssh)} ${var.admin_username}@azure.com"
        }
    }

    default_node_pool {
        name            = "default"
        #node_count      = 1
        vm_size         = "Standard_B2ms"
        enable_auto_scaling = true
        min_count = 1
        max_count = 5
    }

    service_principal {
        client_id     = var.client_id
        client_secret = var.client_secret
    }
}

output "cluster_client_key" {
    value = azurerm_kubernetes_cluster.cluster.kube_config[0].client_key
    sensitive = true
}

output "cluster_client_certificate" {
    value = azurerm_kubernetes_cluster.cluster.kube_config[0].client_certificate
}

output "cluster_cluster_ca_certificate" {
    value = azurerm_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate
}

output "cluster_cluster_username" {
    value = azurerm_kubernetes_cluster.cluster.kube_config[0].username
}

output "cluster_cluster_password" {
    value = azurerm_kubernetes_cluster.cluster.kube_config[0].password
    sensitive = true
}

output "cluster_kube_config" {
    value = azurerm_kubernetes_cluster.cluster.kube_config_raw
    sensitive = true
}

output "cluster_host" {
    value = azurerm_kubernetes_cluster.cluster.kube_config[0].host
}
