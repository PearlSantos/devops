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
  description = "Azure Resource Group containing the IP address"
}

variable "public_ip_name" {
  description = "Name of the public IP to add a domain name label for"
  type = "list"
}

variable "domain_name_label" {
  description = "Domain Name to add to the IP address"
}

variable "azure_location" {
  description = "Region where Azure resource is deployed."
  default = "southeastasia"
}

variable "count" {
  description = "number of domain names to add"
  default = 1
}