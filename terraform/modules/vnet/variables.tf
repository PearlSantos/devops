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

variable "cidr" {
  description = "CIDR range of the only subnet in the VPC"
}

variable "azure_location" {
  description = "Azure Location"
  default = "southeastasia"
}

variable "resource_group_name" {
  description = "Azure Resource Group Name"
}