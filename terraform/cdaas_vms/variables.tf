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
  default     = "CDAASAsiaSampleRG"
}

variable "sample_vm_name" {
  description = "Name of sample VM"
  default     = "CDAASAsiaPipelineSampleVM"
}

variable "cidr" {
  description = "CIDR range of the resource group"
}

variable "cidr_subnet" {
  description = "CIDR range of the subnet"
}

variable "ibss_manila_public_ip" {
  description = "Public IP of IBSS Manila Network"
}

variable "agent_ip" {
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
    source_address_prefixes    = ["${var.ibss_manila_public_ip}", "${var.agent_ip}"]
    destination_address_prefix = "*"
  }]
}
