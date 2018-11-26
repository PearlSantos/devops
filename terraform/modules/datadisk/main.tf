provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

resource "azurerm_managed_disk" "default" {
  count                = "${var.count}"
  name                 = "${var.virtual_machine_name[count.index]}-datadisk"
  location             = "${var.azure_location}"
  resource_group_name  = "${var.resource_group_name}"
  storage_account_type = "${var.managed_disk_type}"
  create_option        = "Empty"
  disk_size_gb         = 500
}

output "datadisk_id" {
  value = "${azurerm_managed_disk.default.*.id}"
}