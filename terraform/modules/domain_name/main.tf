provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

resource "azurerm_public_ip" "public_ip" {
  count                         = "${var.count}"
  name                          = "${var.public_ip_name[count.index]}"
  location                      = "${var.azure_location}"
  resource_group_name           = "${var.resource_group_name}"
  public_ip_address_allocation  = "dynamic"
  domain_name_label             = "${var.domain_name_label}"
}