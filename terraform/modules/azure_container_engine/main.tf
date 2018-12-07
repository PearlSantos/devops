provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

resource "azurerm_route_table" "default" {
  name                = "${var.virtual_network_name}-routetable"
  location            = "${var.azure_location}"
  resource_group_name = "${var.resource_group_name}"
}

# ACS Engine Config
data "template_file" "acs_engine_config" {
  template = "${file(var.acs_engine_config_file)}"

  vars {
    master_vm_count                 = "${var.master_vm_count}"
    dns_prefix                      = "${var.dns_prefix}"
    vm_size_master                  = "${var.vm_size_master}"
    vm_size_agent                   = "${var.vm_size_agent}"
    subnet_id_master                = "${var.master_subnet_id}"
    first_master_ip                 = "${var.first_master_ip}"
    vnet_cidr                       = "${var.cidr}"
    pool_vm_count                   = "${var.pool_vm_count}"
    admin_user                      = "${var.admin_user}"
    ssh_key                         = "${var.ssh_key}"
    service_principal_client_id     = "${var.azure_client_id}"
    service_principal_client_secret = "${var.azure_client_secret}"
    service_cidr                    = "${var.service_cidr}"
    dns_service_ip                  = "${var.dns_service_ip}"
  }

  depends_on = ["azurerm_route_table.default"]
}

# Locally output the rendered ACS Engine Config (after substitution has been performed)
resource "null_resource" "render_acs_engine_config" {
  provisioner "local-exec" {
    command = "echo '${data.template_file.acs_engine_config.rendered}' > ${var.acs_engine_config_file_rendered}"
  }

  depends_on = ["data.template_file.acs_engine_config"]
}

# Locally run the ACS Engine to produce the Azure Resource Template for the K8s cluster
resource "null_resource" "run_acs_engine" {
  provisioner "local-exec" {
    command = "acs-engine generate ${var.acs_engine_config_file_rendered}"
  }

  depends_on = ["null_resource.render_acs_engine_config"]
}

# Locally run the Azure 2.0 CLI to create the resource deployment
resource "null_resource" "deploy_acs" {
  provisioner "local-exec" {
    command = "az group deployment create --name ${var.cluster_name} --resource-group ${var.resource_group_name} --template-file '_output/${var.dns_prefix}/azuredeploy.json' --parameters '_output/${var.dns_prefix}/azuredeploy.parameters.json' --verbose"
  }

  depends_on = ["null_resource.run_acs_engine"]
}

# Locally run the Azure 2.0 CLI to fix the routes
resource "null_resource" "fix_routetable" {
  provisioner "local-exec" {
    command = "az network vnet subnet update --name ${var.master_subnet_name} --resource-group ${var.resource_group_name} --vnet-name ${var.virtual_network_name} --route-table $(az resource list --resource-group ${var.resource_group_name} --resource-type Microsoft.Network/routeTables | jq -r '.[] | .id')"
  }
}

#  depends_on = ["null_resource.deploy_acs"]
#}

