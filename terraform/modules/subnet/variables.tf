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

variable "virtual_network_name" {
  description = "Name of the virtual network"
}

variable "cidr_subnet" {
  description = "CIDR range of the only subnet in the VPC"
}

variable "subnet_name" {
  description = "Name of the subnet to be created"
}

variable "count" {
  description = "Number of resources to create"
  default     = 1
}
