provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

data "azurerm_virtual_network" "rg1_vnet" {
  name          = "${var.azure_virtual_network_1}"
  resource_group_name = "${var.azure_resource_group_1}"
  #name = "${var.azure_resource_group_1}-vnet"
}

data "azurerm_virtual_network" "rg2_vnet" {
  name          = "${var.azure_virtual_network_2}"
  resource_group_name = "${var.azure_resource_group_2}"
  #name = "${var.azure_resource_group_2}-vnet"
}

# this assumes that two resource groups with vnets have already been provisioned
resource "azurerm_virtual_network_peering" "rg1_to_rg2" {
  name                          = "${var.azure_resource_group_1}To${var.azure_resource_group_2}"
  resource_group_name           = "${var.azure_resource_group_1}"
  virtual_network_name          = "${data.azurerm_virtual_network.rg1_vnet.name}"
  remote_virtual_network_id     = "${data.azurerm_virtual_network.rg2_vnet.id}"
  allow_virtual_network_access  = true 
}

resource "azurerm_virtual_network_peering" "rg2_to_rg1" {
  name                          = "${var.azure_resource_group_2}To${var.azure_resource_group_1}"
  resource_group_name           = "${var.azure_resource_group_2}"
  virtual_network_name          = "${data.azurerm_virtual_network.rg2_vnet.name}"
  remote_virtual_network_id     = "${data.azurerm_virtual_network.rg1_vnet.id}"
  allow_virtual_network_access  = true
}