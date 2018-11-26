provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

resource "azurerm_virtual_machine_data_disk_attachment" "default" {
  count              = "${var.count}"
  managed_disk_id    = "${var.managed_disk_id[count.index]}"
  virtual_machine_id = "${var.virtual_machine_id[count.index]}"
  lun                = "1"
  caching            = "ReadWrite"
}
