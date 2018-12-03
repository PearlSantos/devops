data "azurerm_public_ip" "vm_ip" {
  name                = "${var.vm_name}0-ip"
  resource_group_name = "${var.resource_group_name}"
}

output "public_ip_address" {
  value = "${data.azurerm_public_ip.vm_ip.ip_address}"
}
