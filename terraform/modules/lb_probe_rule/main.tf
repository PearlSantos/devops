provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

resource "azurerm_lb_probe" "probe" {
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${var.loadbalancer_id}"
  name                = "${var.loadbalancer_probe_rule_name}"
  protocol            = "${var.loadbalancer_protocol}"
  port                = "${var.loadbalancer_backend_port}"
}

resource "azurerm_lb_rule" "rule" {
  resource_group_name            = "${var.resource_group_name}"
  loadbalancer_id                = "${var.loadbalancer_id}"
  name                           = "${var.loadbalancer_probe_rule_name}"
  protocol                       = "${var.loadbalancer_protocol}"
  frontend_port                  = "${var.loadbalancer_frontend_port}"
  backend_port                   = "${var.loadbalancer_backend_port}"
  frontend_ip_configuration_name = "${var.loadbalancer_frontend_ip_name}"
  backend_address_pool_id        = "${var.loadbalancer_backend_address_pool_id}"
  probe_id                       = "${azurerm_lb_probe.probe.id}"
}
