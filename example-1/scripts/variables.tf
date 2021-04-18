variable app_name {
    type = string
    default = "flixtube"
}
variable location {
    type = string
    default = "West Europe"
}

variable admin_username {
    type = string
    default = "linux_admin"
}

variable app_version { # Can't be called version! That's a reserved word.
    type = string
    default = "1.0.0"
}

variable client_id {
    type = string
}

variable client_secret {
    type = string
}

# variable storage_account_name {
#     type = string
# }

# variable storage_access_key {
#     type = string
# }
