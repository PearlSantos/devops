provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

resource "azurerm_subnet" "default" {
  name                 = "${var.subnet_name}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${var.virtual_network_name}"
  address_prefix       = "${var.cidr_subnet}"
}

output "subnet_id" {
  value = "${azurerm_subnet.default.id}"
}

output "subnet_name" {
  value = "${azurerm_subnet.default.name}"
}

output "address_prefix" {
  value = "${azurerm_subnet.default.address_prefix}"
}
