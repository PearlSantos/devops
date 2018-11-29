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
  default     = "Standard_B2s"

  #default     = "Standard_D2s_v3"
}

variable "managed_disk_type" {
  description = "Standard or Premium managed disk type"
  default     = "Premium_LRS"
}

variable "ibss_manila_public_ip" {
  description = "Public IP of IBSS Manila Network"
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
    source_address_prefix      = "${var.ibss_manila_public_ip}"
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

variable "domain_name_label" {
  description = "Publicly accessible Domain Name"
}

variable "ip_assignment" {
  description = "Use static or dynamic IP"
  default     = "dynamic"
}
