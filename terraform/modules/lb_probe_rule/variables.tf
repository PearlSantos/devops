variable "azure_subscription_id" {
  description = "Azure Subscription ID"
}

variable "azure_client_id" {
  description = "Azure Client ID"
}

variable "azure_client_secret" {
  description = "Azure Client Secret"
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID"
}

variable "resource_group_name" {
  description = "Azure Resource Group Name"
}

variable "azure_location" {
  description = "Azure Location"
  default     = "southeastasia"
}

variable "loadbalancer_id" {
  description = "ID of Azure LB"
}

variable "loadbalancer_probe_rule_name" {
  description = "Name of probe rule"
}

variable "loadbalancer_protocol" {
  description = "Protocol of LB"
  default     = "Tcp"
}

variable "loadbalancer_backend_port" {
  description = "Backend port for load balancer rule and probe"
}

variable "loadbalancer_frontend_port" {
  description = "Frontend port for load balancer"
}

variable "loadbalancer_frontend_ip_name" {
  description = "Name of frontend ip of lb to initialize rule"
}

variable "loadbalancer_backend_address_pool_id" {
  description = "Name of backend address pool for lb rule."
}
