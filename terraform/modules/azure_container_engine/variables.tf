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

variable "azure_location" {
  description = "Azure Location"
  default     = "southeastasia"
}

variable "resource_group_name" {
  description = "Azure Resource Group Name"
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
}

variable "acs_engine_config_file" {
  description = "File name and location of the ACS Engine config file"
  default     = "../modules/azure_container_engine/k8s.json"
}

variable "acs_engine_config_file_rendered" {
  description = "File name and location of the ACS Engine config file"
  default     = "k8s_rendered.json"
}

variable "master_vm_count" {
  description = "Number of master VMs to create"
  default     = 1
}

variable "dns_prefix" {
  description = "DNS prefix for the cluster"
}

variable "vm_size_master" {
  description = "Azure VM type"
  default     = "Standard_D4_v3"
}

variable "vm_size_agent" {
  description = "Azure VM type"
  default     = "Standard_D4_v3"
}

variable "first_master_ip" {
  description = "First consecutive IP address to be assigned to master nodes"
  default     = "10.1.253.200"
}

variable "pool_vm_count" {
  description = "Number of worker VMs to initially create per pool"
  default     = 4
}

variable "admin_user" {
  description = "Administrative username for the VMs"
  default     = "azureuser"
}

variable "ssh_key" {
  description = "SSH public key in PEM format to apply to VMs"
}

variable "cluster_name" {
  description = "Name of the K8s cluster"
}

variable "master_subnet_id" {
  description = "ID of the cluster subnet"
}

variable "master_subnet_name" {
  description = "Name of the cluster subnet"
}

variable "cidr" {
  description = "Azure VNet CIDR"
  default     = "10.1.0.0/16"
}

variable "cidr_subnet" {
  description = "CIDR range of the master subnet in the VNet"
  default     = "10.1.0.0/16"
}

variable "service_cidr" {
  description = "IP range for Service IPs"
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  description = "IP address for kube-dns to listen on"
  default     = "10.0.0.10/16"
}
