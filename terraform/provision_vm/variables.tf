variable "azure_subscription_id" {
  description = "Azure Subscription ID"
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID"
}

variable "azure_client_id" {
  description = "Azure Client ID"
}

variable "azure_client_secret" {
  description = "Azure Client Secret"
}

variable "ssh_key" {
  description = "SSH public key in PEM format to apply to VMs"
}

variable "resource_group_name" {
  description = "Azure Resource Group Name"
}

variable "cidr" {
  description = "CIDR range of the resource group"
}

variable "cidr_subnet" {
  description = "CIDR range of the subnet"
}

variable "vm_name" {
  description = "Name of the VM"
}
