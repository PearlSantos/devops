provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

resource "azurerm_public_ip" "default" {
  count                        = "${var.count}"
  name                         = "${var.virtual_machine_name}-ip"
  location                     = "${var.azure_location}"
  resource_group_name          = "${var.resource_group_name}"
  public_ip_address_allocation = "${var.ip_assignment}"
}

resource "azurerm_network_security_group" "default" {
  name                = "${var.virtual_machine_name}-nsg"
  location            = "${var.azure_location}"
  resource_group_name = "${var.resource_group_name}"

  security_rule = "${var.security_rule}"
}

resource "azurerm_network_interface" "default" {
  name                      = "${var.virtual_machine_name}-nic"
  location                  = "${var.azure_location}"
  resource_group_name       = "${var.resource_group_name}"
  network_security_group_id = "${azurerm_network_security_group.default.id}"

  ip_configuration {
    name                          = "default_ip_config"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.default.id}"
  }
}

# initialize disks
# TODO: image should come from VM image
data "azurerm_image" "fis_os_image" {
  name                = "R4_1_FISOS_image"
  resource_group_name = "INGAsiaFISProfileSnapshots"
}

data "azurerm_managed_disk" "fis_data_disk_0" {
  name                = "R4_1_FISDataDisk_0"
  resource_group_name = "INGAsiaFISProfileSnapshots"
}

data "azurerm_managed_disk" "fis_data_disk_1" {
  name                = "R4_1_FISDataDisk_1"
  resource_group_name = "INGAsiaFISProfileSnapshots"
}

resource "azurerm_managed_disk" "fis_data_disk_0_copy" {
  name                 = "R4_1_FISDataDisk_0"
  resource_group_name  = "${var.resource_group_name}"
  location             = "southeastasia"
  storage_account_type = "Standard_LRS"
  create_option        = "Copy"
  source_resource_id   = "${data.azurerm_managed_disk.fis_data_disk_0.id}"
}

resource "azurerm_managed_disk" "fis_data_disk_1_copy" {
  name                 = "R4_1_FISDataDisk_1"
  resource_group_name  = "${var.resource_group_name}"
  location             = "southeastasia"
  storage_account_type = "Standard_LRS"
  create_option        = "Copy"
  source_resource_id   = "${data.azurerm_managed_disk.fis_data_disk_1.id}"
}

resource "azurerm_virtual_machine" "default" {
  name                  = "${var.virtual_machine_name}"
  location              = "${var.azure_location}"
  resource_group_name   = "${var.resource_group_name}"
  network_interface_ids = ["${azurerm_network_interface.default.id}"]
  vm_size               = "${var.vm_size}"

  storage_image_reference {
    id = "${data.azurerm_image.fis_os_image.id}"
  }

  storage_os_disk {
    name          = "${var.virtual_machine_name}-osdisk"
    create_option = "FromImage"
  }

  # TODO: image VM including datadisks
  storage_data_disk {
    name            = "R4_1_FISDataDisk_0"
    create_option   = "Attach"
    lun             = 0
    managed_disk_id = "${azurerm_managed_disk.fis_data_disk_0_copy.id}"
    disk_size_gb    = "${azurerm_managed_disk.fis_data_disk_0_copy.disk_size_gb}"
  }

  storage_data_disk {
    name            = "R4_1_FISDataDisk_1"
    create_option   = "Attach"
    lun             = 1
    managed_disk_id = "${azurerm_managed_disk.fis_data_disk_1_copy.id}"
    disk_size_gb    = "${azurerm_managed_disk.fis_data_disk_1_copy.disk_size_gb}"
  }

  os_profile {
    computer_name  = "${var.computer_name}"
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
