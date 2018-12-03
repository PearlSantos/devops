module "resource_group" {
  source                = "../modules/resource_group"
  azure_subscription_id = "${var.azure_subscription_id}"
  azure_client_id       = "${var.azure_client_id}"
  azure_client_secret   = "${var.azure_client_secret}"
  azure_tenant_id       = "${var.azure_tenant_id}"
  resource_group_name   = "${var.resource_group_name}"
}

# vnet name should default to <resource_group_name>-vnet
module "vnet" {
  source                = "../modules/vnet"
  azure_subscription_id = "${var.azure_subscription_id}"
  azure_client_id       = "${var.azure_client_id}"
  azure_client_secret   = "${var.azure_client_secret}"
  azure_tenant_id       = "${var.azure_tenant_id}"
  cidr                  = "${var.cidr}"
  resource_group_name   = "${module.resource_group.name}"
}

module "subnet" {
  source                = "../modules/subnet"
  azure_subscription_id = "${var.azure_subscription_id}"
  azure_client_id       = "${var.azure_client_id}"
  azure_client_secret   = "${var.azure_client_secret}"
  azure_tenant_id       = "${var.azure_tenant_id}"
  resource_group_name   = "${module.resource_group.name}"
  virtual_network_name  = "${module.vnet.name}"
  cidr_subnet           = "${var.cidr_subnet}"
  subnet_name           = "${var.resource_group_name}-subnet"
}
