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

variable "ssh_key" {
  description = "SSH public key in PEM format to apply to VMs"
}

variable "count" {
  description = "Number of resources to create"
  default     = 1
}

variable "azure_location" {
  description = "Azure Location"
  default     = "southeastasia"
}

variable "resource_group_name" {
  description = "Azure Resource Group Name"
}

variable "subnet_id" {
  description = "A mapping of tags to assign to a resource"
}

variable "cidr_subnet" {
  description = "CIDR range of the only subnet in the VPC"
}

variable "virtual_machine_name" {
  description = "Name of the virtual machine"
}

variable "vm_size" {
  description = "Azure VM type"
  default     = "Standard_D2s_v3"
}

variable "managed_disk_type" {
  description = "Standard or Premium managed disk type"
  default     = "Premium_LRS"
}

variable "security_rule" {
  description = "Array of security group rules."

  default = [{
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "210.213.248.78/32"
    destination_address_prefix = "*"
  }]
}

variable "computer_name" {
  description = "Name of the os profile computer name"
  default     = "hostname"
}

variable "admin_user" {
  description = "Administrative username for the VMs"
  default     = "azureuser"
}

variable "tags" {
  type        = "map"
  description = "A mapping of tags to assign to a resource"
}

variable "storage_image_reference_publisher" {
  default = "OpenLogic"
}

variable "storage_image_reference_offer" {
  default = "CentOS"
}

variable "storage_image_reference_sku" {
  default = "7.4"
}

variable "storage_image_reference_version" {
  default = "latest"
}

variable "ip_assignment" {
  description = "Use static or dynamic IP"
  default     = "dynamic"
}

variable "admin_pass" {
  description = "Windows Admin Password"
}
