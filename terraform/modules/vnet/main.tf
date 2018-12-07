provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

resource "azurerm_virtual_network" "default" {
    name                = "${var.resource_group_name}-vnet"
    address_space       = ["${var.cidr}"]
    location            = "${var.azure_location}"
    resource_group_name = "${var.resource_group_name}"
}

output "name" {
  value = "${azurerm_virtual_network.default.name}"
}