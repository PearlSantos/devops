provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

resource "azurerm_network_security_group" "default" {
  name                = "${var.virtual_machine_name}-nsg"
  location            = "${var.azure_location}"
  resource_group_name = "${var.resource_group_name}"

  security_rule = "${var.security_rule}"
}

resource "azurerm_network_interface" "default" {
  count                     = "${var.count}"
  name                      = "${var.virtual_machine_name}${count.index}-nic"
  location                  = "${var.azure_location}"
  resource_group_name       = "${var.resource_group_name}"
  network_security_group_id = "${azurerm_network_security_group.default.id}"

  ip_configuration {
    name                          = "default_ip_config"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_virtual_machine" "default" {
  count                         = "${var.count}"
  name                          = "${var.virtual_machine_name}_${count.index}"
  location                      = "${var.azure_location}"
  resource_group_name           = "${var.resource_group_name}"
  network_interface_ids         = ["${azurerm_network_interface.default.*.id[count.index]}"]
  vm_size                       = "${var.vm_size}"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "${var.storage_image_reference_publisher}"
    offer     = "${var.storage_image_reference_offer}"
    sku       = "${var.storage_image_reference_sku}"
    version   = "${var.storage_image_reference_version}"
  }

  storage_os_disk {
    name              = "${var.virtual_machine_name}${count.index}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "${var.managed_disk_type}"
  }

  os_profile {
    computer_name  = "${var.computer_name}${count.index}"
    admin_username = "${var.admin_user}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = "${var.ssh_key}"
    }
  }

  tags = "${var.tags}"
}

output "vm_name" {
  value = "${azurerm_virtual_machine.default.*.name}"
}

output "vm_id" {
  value = "${azurerm_virtual_machine.default.*.id}"
}