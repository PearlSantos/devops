provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

data "azurerm_virtual_network" "vnet" {
  name                = "openshiftvnet"
  resource_group_name = "ingasiabenedict"
}

data "azurerm_subnet" "subnet" {
  name                 = "mastersubnet"
  resource_group_name  = "${data.azurerm_virtual_network.vnet.resource_group_name}"
  virtual_network_name = "${data.azurerm_virtual_network.vnet.name}"
}

module "cdaas_vm" {
  source                = "../modules/vm"
  azure_subscription_id = "${var.azure_subscription_id}"
  azure_client_id       = "${var.azure_client_id}"
  azure_client_secret   = "${var.azure_client_secret}"
  azure_tenant_id       = "${var.azure_tenant_id}"
  ssh_key               = "${var.ssh_key}"
  resource_group_name   = "${data.azurerm_virtual_network.vnet.resource_group_name}"
  cidr_subnet           = "${var.cidr_subnet}"
  subnet_id             = "${data.azurerm_subnet.subnet.id}"

  security_rule = [{
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefixes    = ["${var.ibss_manila_public_ip}", "${var.agent_ip}"]
    destination_address_prefix = "*"
  }]

  vm_size           = "Standard_DS3_v2"
  managed_disk_type = "Standard_LRS"

  virtual_machine_name = "${var.vm_name}"
  computer_name        = "${var.vm_name}"
  domain_name_label    = "${lower(var.vm_name)}"

  tags = {
    app               = "cdaas-asia-vm"
    role              = "sample"
    shutdown_weekends = "true"
  }
}
