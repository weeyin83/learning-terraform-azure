## 
# Local variables
##

locals {
  resource_group_name = "${var.naming_prefix}-rg"
  sql_server_name     = "${var.naming_prefix}sql"
  admin_password      = try(random_password.admin_password[0].result, var.admin_password)
}

resource "random_password" "admin_password" {
  count       = var.admin_password == null ? 1 : 0
  length      = 20
  special     = true
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
}


# Create Resource Group
resource "azurerm_resource_group" "techielassrg" {
  name     = local.resource_group_name
  location = var.location
  tags = {
    usage = var.tag_usage
    owner = var.tag_owner
  }
}

resource "azurerm_mssql_server" "speaking_sql_server" {
  name                         = local.sql_server_name
  resource_group_name          = azurerm_resource_group.techielassrg.name
  location                     = azurerm_resource_group.techielassrg.location
  version                      = "12.0"
  administrator_login          = var.admin_user
  administrator_login_password = local.admin_password
  minimum_tls_version          = "1.2"

  tags = {
    usage = var.tag_usage
    owner = var.tag_owner
  }
}

resource "azurerm_mssql_firewall_rule" "sql_server_firewall_rule" {
  name             = "Allow_Your_IP_Address"
  server_id        = azurerm_mssql_server.speaking_sql_server.id
  start_ip_address = var.allowed_ip_address
  end_ip_address   = var.allowed_ip_address
}

resource "azurerm_mssql_database" "speaking_record_db" {
  name           = "SpeakingLogs"
  server_id      = azurerm_mssql_server.speaking_sql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  sku_name       = "Basic"
  zone_redundant = false

  tags = {
    usage = var.tag_usage
    owner = var.tag_owner
  }
}

output "token_value" {
  value = nonsensitive(local.admin_password)
}
