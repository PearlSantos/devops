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

module "sample_vm" {
  source                = "../modules/vm"
  azure_subscription_id = "${var.azure_subscription_id}"
  azure_client_id       = "${var.azure_client_id}"
  azure_client_secret   = "${var.azure_client_secret}"
  azure_tenant_id       = "${var.azure_tenant_id}"
  ssh_key               = "${var.ssh_key}"
  resource_group_name   = "${module.resource_group.name}"
  cidr_subnet           = "${var.cidr_subnet}"
  subnet_id             = "${module.subnet.subnet_id}"

  vm_size           = "Standard_DS3_v2"
  managed_disk_type = "Standard_LRS"

  virtual_machine_name = "CDAASAsiaPipelineSampleVM"
  computer_name        = "cdaas-asia-sample-vm-test"
  domain_name_label    = "cdaas-asia-sample-vm-test"

  tags = {
    app               = "cdaas-asia-vm"
    role              = "sample"
    shutdown_weekends = "true"
  }

  output "public_ip_address" {
    value = "${module.sample_vm.virtual_machine_name}0-ip.ip_address"
  }
}
