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

variable "resource_group_name" {
  description = "Azure Resource Group Name"
}

variable "_artifactsLocation" {
  description = "Location where scripts will be picked up by the Azure resource"
  default     = "https://raw.githubusercontent.com/Microsoft/openshift-origin/release-3.9"
}

variable "masterVmSize" {
  description = "Size of the master nodes"
  default     = "Standard_D4s_v3"
}

variable "infraVmSize" {
  description = "Size of the infra nodes"
  default     = "Standard_D4s_v3"
}

variable "nodeVmSize" {
  description = "Size of the compute nodes"
  default     = "Standard_D4s_v3"
}

variable "storageKind" {
  description = "Type of disk"
  default     = "managed"
}

variable "openshiftClusterPrefix" {
  description = "The name for each individual component"
  default     = "ingasiaos"
}

variable "masterInstanceCount" {
  description = "Number of master instances."
  default     = "1"
}

variable "infraInstanceCount" {
  description = "Number of infra lb instances"
  default     = "1"
}

variable "nodeInstanceCount" {
  description = "Number of compute nodes."
  default     = "1"
}

variable "dataDiskSize" {
  description = "Size of the data disk"
  default     = "128"
}

variable "adminUsername" {
  description = "Admin username for openshift"
}

variable "openshiftPassword" {
  description = "Admin passworf for openshift"
}

variable "enableMetrics" {
  description = "Enable metrics"
  default     = "true"
}

variable "enableLogging" {
  description = "Enable logging"
  default     = "false"
}

variable "sshPublicKey" {
  description = "The public key for the SSH key to be used by the machines. Must match the key stored in the corresponding key vault."
}

variable "keyVaultResourceGroup" {
  description = "The resource group for the key vault."
}

variable "keyVaultName" {
  description = "The name of key vault where the SSH key for OpenShift is stored."
}

variable "keyVaultSecret" {
  description = "The name of the key vault secret where the SSH key for OpenShift is stored."
}

variable "enableAzure" {
  description = "Enable Azure features."
  default     = "true"
}

variable "aadClientId" {
  description = "Client ID for the service account."
}

variable "aadClientSecret" {
  description = "Client Secret for the service account"
}

variable "defaultSubDomainType" {
  description = "The type of subdomain."
  default     = "nipio"
}

variable "addressPrefix" {
  description = "Address of the VNet to be generated."
  default     = "10.0.0.0/8"
}

variable "masterSubnetPrefix" {
  description = "Subnet prefix for master nodes."
  default     = "10.1.0.0/16"
}

variable "nodeSubnetPrefix" {
  description = "Subnet prefix for compute nodes."
  default     = "10.2.0.0/16"
}

variable "infraLbPublicIpDnsLabel" {
  description = "Public dns label for infra lb."
  default     = "ingasiaosinfra"
}

variable "openshiftMasterPublicIpDnsLabel" {
  description = "Public dns label of master lb."
  default     = "ingasiaosmaster"
}
