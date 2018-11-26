data "azurerm_client_config" "current" {}

provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

resource "azurerm_key_vault" "key_vault" {
  name                = "${var.key_vault_name}"
  location            = "southeastasia"
  resource_group_name = "${var.resource_group_name}"

  sku {
    name = "standard"
  }

  tenant_id = "${var.azure_tenant_id}"

  access_policy {
    tenant_id = "${var.azure_tenant_id}"
    object_id = "${data.azurerm_client_config.current.service_principal_object_id}"

    key_permissions = [
      "get",
      "create",
      "delete",
      "list",
      "update",
      "import",
      "backup",
      "restore",
      "recover",
    ]

    secret_permissions = [
      "get",
      "list",
      "set",
      "delete",
      "backup",
      "restore",
      "recover",
    ]

    certificate_permissions = [
      "get",
      "list",
      "delete",
      "create",
      "import",
      "update",
      "managecontacts",
      "getissuers",
      "listissuers",
      "setissuers",
      "deleteissuers",
      "manageissuers",
      "recover",
    ]
  }

  enabled_for_disk_encryption     = true
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
}

output "key_vault_id" {
  value = "${azurerm_key_vault.key_vault.id}"
}

output "key_vault_uri" {
  value = "${azurerm_key_vault.key_vault.vault_uri}"
}
