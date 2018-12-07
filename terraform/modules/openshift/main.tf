provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

resource "azurerm_template_deployment" "openshift" {
  name                = "${var.resource_group_name}-os-template"
  resource_group_name = "${var.resource_group_name}"

  template_body = <<DEPLOY
{
	"$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json",
	"contentVersion": "1.0.0.0",
	"parameters": {
		"_artifactsLocation": {
			"type": "string",
			"metadata": {
				"description": "The base URL where artifacts required by this template are located. When the template is deployed using the accompanying scripts, a private location in the subscription will be used and this value will be automatically generated.",
				"artifactsBaseUrl": ""
			},
			"defaultValue": "https://raw.githubusercontent.com/Microsoft/openshift-origin/release-3.9"
		},
		"masterVmSize": {
			"type": "string",
			"defaultValue": "Standard_DS3_v2",
			"allowedValues": [
				"Standard_A4", "Standard_A5", "Standard_A6", "Standard_A7", "Standard_A8", "Standard_A9", "Standard_A10", "Standard_A11",
				"Standard_D1", "Standard_D2", "Standard_D3", "Standard_D4",
				"Standard_D11", "Standard_D12", "Standard_D13", "Standard_D14",
				"Standard_D1_v2", "Standard_D2_v2", "Standard_D3_v2", "Standard_D4_v2", "Standard_D5_v2",
				"Standard_D11_v2", "Standard_D12_v2", "Standard_D13_v2", "Standard_D14_v2",
				"Standard_G1", "Standard_G2", "Standard_G3", "Standard_G4", "Standard_G5",
				"Standard_D1_v2", "Standard_DS2", "Standard_DS3", "Standard_DS4",
				"Standard_DS11", "Standard_DS12", "Standard_DS13", "Standard_DS14",
				"Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2", "Standard_DS4_v2", "Standard_DS5_v2",
				"Standard_DS11_v2", "Standard_DS12_v2", "Standard_DS13_v2", "Standard_DS14_v2",
				"Standard_GS1", "Standard_GS2", "Standard_GS3", "Standard_GS4", "Standard_GS5",
				"Standard_D2_v3", "Standard_D4_v3", "Standard_D8_v3", "Standard_D16_v3", "Standard_D32_v3", "Standard_D64_v3",
				"Standard_D2s_v3", "Standard_D4s_v3", "Standard_D8s_v3", "Standard_D16s_v3", "Standard_D32s_v3", "Standard_D64s_v3",
				"Standard_E2_v3", "Standard_E4_v3", "Standard_E8_v3", "Standard_E16_v3", "Standard_E32_v3", "Standard_E64_v3",
				"Standard_E2s_v3", "Standard_E4s_v3", "Standard_E8s_v3", "Standard_E16s_v3", "Standard_E32s_v3", "Standard_E64s_v3"
			],
			"metadata": {
				"description": "OpenShift Master VM size"
			}
		},
		"nodeVmSize": {
			"type": "string",
			"defaultValue": "Standard_DS3_v2",
			"allowedValues": [
				"Standard_A4", "Standard_A5", "Standard_A6", "Standard_A7", "Standard_A8", "Standard_A9", "Standard_A10", "Standard_A11",
				"Standard_D1", "Standard_D2", "Standard_D3", "Standard_D4",
				"Standard_D11", "Standard_D12", "Standard_D13", "Standard_D14",
				"Standard_D1_v2", "Standard_D2_v2", "Standard_D3_v2", "Standard_D4_v2", "Standard_D5_v2",
				"Standard_D11_v2", "Standard_D12_v2", "Standard_D13_v2", "Standard_D14_v2",
				"Standard_G1", "Standard_G2", "Standard_G3", "Standard_G4", "Standard_G5",
				"Standard_D1_v2", "Standard_DS2", "Standard_DS3", "Standard_DS4",
				"Standard_DS11", "Standard_DS12", "Standard_DS13", "Standard_DS14",
				"Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2", "Standard_DS4_v2", "Standard_DS5_v2",
				"Standard_DS11_v2", "Standard_DS12_v2", "Standard_DS13_v2", "Standard_DS14_v2",
				"Standard_GS1", "Standard_GS2", "Standard_GS3", "Standard_GS4", "Standard_GS5",
				"Standard_D2_v3", "Standard_D4_v3", "Standard_D8_v3", "Standard_D16_v3", "Standard_D32_v3", "Standard_D64_v3",
				"Standard_D2s_v3", "Standard_D4s_v3", "Standard_D8s_v3", "Standard_D16s_v3", "Standard_D32s_v3", "Standard_D64s_v3",
				"Standard_E2_v3", "Standard_E4_v3", "Standard_E8_v3", "Standard_E16_v3", "Standard_E32_v3", "Standard_E64_v3",
				"Standard_E2s_v3", "Standard_E4s_v3", "Standard_E8s_v3", "Standard_E16s_v3", "Standard_E32s_v3", "Standard_E64s_v3"
			],
			"metadata": {
				"description": "OpenShift Node VM(s) size"
			}
		},
		"infraVmSize": {
			"type": "string",
			"defaultValue": "Standard_DS3_v2",
			"allowedValues": [
				"Standard_A4", "Standard_A5", "Standard_A6", "Standard_A7", "Standard_A8", "Standard_A9", "Standard_A10", "Standard_A11",
				"Standard_D1", "Standard_D2", "Standard_D3", "Standard_D4",
				"Standard_D11", "Standard_D12", "Standard_D13", "Standard_D14",
				"Standard_D1_v2", "Standard_D2_v2", "Standard_D3_v2", "Standard_D4_v2", "Standard_D5_v2",
				"Standard_D11_v2", "Standard_D12_v2", "Standard_D13_v2", "Standard_D14_v2",
				"Standard_G1", "Standard_G2", "Standard_G3", "Standard_G4", "Standard_G5",
				"Standard_D1_v2", "Standard_DS2", "Standard_DS3", "Standard_DS4",
				"Standard_DS11", "Standard_DS12", "Standard_DS13", "Standard_DS14",
				"Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2", "Standard_DS4_v2", "Standard_DS5_v2",
				"Standard_DS11_v2", "Standard_DS12_v2", "Standard_DS13_v2", "Standard_DS14_v2",
				"Standard_GS1", "Standard_GS2", "Standard_GS3", "Standard_GS4", "Standard_GS5",
				"Standard_D2_v3", "Standard_D4_v3", "Standard_D8_v3", "Standard_D16_v3", "Standard_D32_v3", "Standard_D64_v3",
				"Standard_D2s_v3", "Standard_D4s_v3", "Standard_D8s_v3", "Standard_D16s_v3", "Standard_D32s_v3", "Standard_D64s_v3",
				"Standard_E2_v3", "Standard_E4_v3", "Standard_E8_v3", "Standard_E16_v3", "Standard_E32_v3", "Standard_E64_v3",
				"Standard_E2s_v3", "Standard_E4s_v3", "Standard_E8s_v3", "Standard_E16s_v3", "Standard_E32s_v3", "Standard_E64s_v3"
			],
			"metadata": {
				"description": "OpenShift Infra Node VM(s) size"
			}
		},
		"storageKind": {
			"type": "string",
			"defaultValue": "managed",
			"allowedValues": ["managed", "unmanaged"],
			"metadata": {
				"description": "Use Managed or Unmanaged Disks"
			}
		},
		"openshiftClusterPrefix": {
			"type": "string",
			"defaultValue": "mycluster",
			"minLength": 2,
			"maxLength": 20,
			"metadata": {
				"description": "OpenShift cluster prefix.  Used to generate master, infra and node hostnames.  Maximum of 20 characters."
			}
		},
		"masterInstanceCount": {
			"type": "string",
			"defaultValue": "1",
			"allowedValues": ["1", "3", "5"],
			"metadata": {
				"description": "Number of OpenShift masters."
			}
		},
		"infraInstanceCount": {
			"type": "string",
			"defaultValue": "1",
			"allowedValues": ["1", "2", "3"],
			"metadata": {
				"description": "Number of OpenShift infra nodes."
			}
		},
		"nodeInstanceCount": {
			"type": "string",
			"defaultValue": "1",
			"allowedValues": ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"],
			"metadata": {
				"description": "Number of OpenShift nodes"
			}
		},
		"dataDiskSize": {
			"type": "string",
			"defaultValue": "64",
			"allowedValues": ["32", "64", "128", "256", "512", "1024", "2048"],
			"metadata": {
				"description": "Size of Datadisk in GB for Docker volume"
			}
		},
		"adminUsername": {
			"type": "string",
			"defaultValue": "clusteradmin",
			"minLength": 1,
			"metadata": {
				"description": "Administrator username on all VMs and first user created for OpenShift login"
			}
		},
		"openshiftPassword": {
			"type": "securestring",
			"minLength": 1,
			"metadata": {
				"description": "Password for OpenShift user to login to OpenShift Console"
			}
		},
		"sshPublicKey": {
			"type": "string",
			"metadata": {
				"description": "SSH public key for all VMs"
			}
		},
		"enableMetrics": {
			"type": "string",
			"defaultValue": "false",
			"allowedValues": [
				"true", "false"
			],
			"metadata": {
				"description": "Enable OpenShift Metrics: true or false"
			}
		},
		"enableLogging": {
			"type": "string",
			"defaultValue": "false",
			"allowedValues": [
				"true", "false"
			],
			"metadata": {
				"description": "Enable OpenShift Logging: true or false"
			}
		},
		"keyVaultResourceGroup": {
			"type": "string",
			"minLength": 1,
			"metadata": {
				"description": "Resource Group that contains the Key Vault"
			}
		},
		"keyVaultName": {
			"type": "string",
			"minLength": 1,
			"metadata": {
				"description": "Name of the Key Vault"
			}
		},
		"keyVaultSecret": {
			"type": "string",
			"minLength": 1,
			"metadata": {
				"description": "Key Vault Secret Name that contains the Private Key"
			}
		},
		"enableAzure": {
			"type": "string",
			"defaultValue": "true",
			"allowedValues": [
				"true", "false"
			],
			"metadata": {
				"description": "Enable Azure as Cloud Provider - true or false"
			}
		},
		"aadClientId": {
			"type": "string",
			"defaultValue": "",
			"metadata": {
				"description": "Azure AD Client ID"
			}
		},
		"aadClientSecret": {
			"type": "securestring",
			"defaultValue": "",
			"metadata": {
				"description": "Azure AD Client Secret"
			}
		},
		"defaultSubDomainType": {
			"type": "string",
			"defaultValue": "nipio",
			"allowedValues": [
				"nipio", "custom"
			],
			"metadata": {
				"description": "Default Subdomain type - nip.io or custom (defined in next parameter)"
			}
		},
		"defaultSubDomain": {
			"type": "string",
			"defaultValue": "contoso.com",
			"metadata": {
				"description": "Default Subdomain for application routing (Wildcard DNS) - must enter something even if you are using nip.io"
			}
		},
    "addressPrefix": {
      "type": "string",
      "defaultValue": "10.0.0.0/8",
      "metadata": {
        "description": "Default VNet address prefix. Subnets must be within the addressable range of the VNet."
      }
    },
    "masterSubnetPrefix": {
      "type": "string",
      "defaultValue": "10.1.0.0/16",
      "metadata": {
        "description": "The subnet address prefix for master VMs."
      }
    },
    "nodeSubnetPrefix": {
      "type": "string",
      "defaultValue": "10.2.0.0/16",
      "metadata": {
        "description": "The subnet address prefix for master VMs."
      }
    },
    "infraLbPublicIpDnsLabel": {
			"type": "string",
			"defaultValue": "ingasiaosinfra",
			"metadata": {
				"description": "Public DNS name of the infra load balancer. Must be unique."
			}
		},
    "openshiftMasterPublicIpDnsLabel": {
			"type": "string",
			"defaultValue": "ingasiaosmaster",
			"metadata": {
				"description": "Public DNS name of the master load balancer. Must be unique."
			}
		}
	},
	"variables": {
		"masterInstanceCount": "[int(parameters('masterInstanceCount'))]",
		"nodeInstanceCount": "[int(parameters('nodeInstanceCount'))]",
		"infraInstanceCount": "[int(parameters('infraInstanceCount'))]",
		"dataDiskSize": "[int(parameters('dataDiskSize'))]",
    "addressPrefix": "[parameters('addressPrefix')]",
    "masterSubnetPrefix": "[parameters('masterSubnetPrefix')]",
    "nodeSubnetPrefix": "[parameters('nodeSubnetPrefix')]",
    "infraLbPublicIpDnsLabel": "[parameters('infraLbPublicIpDnsLabel')]",
    "openshiftMasterPublicIpDnsLabel": "[parameters('openshiftMasterPublicIpDnsLabel')]",
		"location": "[resourceGroup().location]",
		"resourceGroupName": "[resourceGroup().id]",
		"apiVersionCompute": "2017-03-30",
		"apiVersionNetwork": "2017-09-01",
		"apiVersionStorage": "2017-06-01",
		"apiVersionLinkTemplate": "2015-01-01",
		"defaultSubDomain": "[toLower(parameters('defaultSubDomain'))]",
		"namingInfix": "[toLower(parameters('openshiftClusterPrefix'))]",
		"openshiftMasterHostname": "[concat(variables('namingInfix'), '-master')]",
		"openshiftNodeHostname": "[concat(variables('namingInfix'), '-node')]",
		"openshiftInfraHostname": "[concat(variables('namingInfix'), '-infra')]",
		"newStorageAccountMaster": "[concat('master', uniqueString(concat(resourceGroup().id, 'msa')))]",
		"newStorageAccountInfra": "[concat('infra', uniqueString(concat(resourceGroup().id, 'infra')))]",
		"newStorageAccountNodeOs": "[concat('nodeos', uniqueString(concat(resourceGroup().id, 'nodeossa')))]",
		"newStorageAccountNodeData": "[concat('nodedata', uniqueString(concat(resourceGroup().id, 'nodedatasa')))]",
		"diagStorageAccount1": "[concat('diag1', uniqueString(concat(resourceGroup().id, 'dsa1')))]",
		"diagStorageAccount2": "[concat('diag2', uniqueString(concat(resourceGroup().id, 'dsa2')))]",
		"newStorageAccountRegistry": "[concat('registry', uniqueString(concat(resourceGroup().id, 'registry')))]",
		"newStorageAccountPersistentVolume1": "[concat('pv1sa', uniqueString(concat(resourceGroup().id, 'persistentvolume1')))]",
		"newStorageAccountArray": [
			{ "name": "[variables('diagStorageAccount1')]", "tagName": "DiagnosticsStorageAccount", "skuName": "[variables('storageSkuObject').diagnostics.skuName]", "skuTier": "[variables('storageSkuObject').diagnostics.skuTier]" },
			{ "name": "[variables('diagStorageAccount2')]", "tagName": "DiagnosticsStorageAccount", "skuName": "[variables('storageSkuObject').diagnostics.skuName]", "skuTier": "[variables('storageSkuObject').diagnostics.skuTier]" },
			{ "name": "[variables('newStorageAccountRegistry')]", "tagName": "RegistryStorageAccount", "skuName": "[variables('storageSkuObject').registry.skuName]", "skuTier": "[variables('storageSkuObject').registry.skuTier]" },
			{ "name": "[variables('newStorageAccountMaster')]", "tagName": "MasterStorageAccount", "skuName": "[variables('storageSkuObject').master.skuName]", "skuTier": "[variables('storageSkuObject').master.skuTier]" },
			{ "name": "[variables('newStorageAccountInfra')]", "tagName": "InfraStorageAccount", "skuName": "[variables('storageSkuObject').infra.skuName]", "skuTier": "[variables('storageSkuObject').infra.skuTier]" },
			{ "name": "[variables('newStorageAccountNodeOs')]", "tagName": "NodeStorageAccount", "skuName": "[variables('storageSkuObject').node.skuName]", "skuTier": "[variables('storageSkuObject').node.skuTier]" },
			{ "name": "[variables('newStorageAccountNodeData')]", "tagName": "NodeStorageAccount", "skuName": "[variables('storageSkuObject').node.skuName]", "skuTier": "[variables('storageSkuObject').node.skuTier]" },
			{ "name": "[variables('newStorageAccountPersistentVolume1')]", "tagName": "PersistentVolume1StorageAccount", "skuName": "[variables('storageSkuObject').persistent.skuName]", "skuTier": "[variables('storageSkuObject').persistent.skuTier]" }
		],
		"availabilitySetArray": [
			{ "name": "masteravailabilityset", "tagName": "MasterAvailabilitySet" },
			{ "name": "infraavailabilityset", "tagName": "InfraAvailabilitySet" },
			{ "name": "nodeavailabilityset", "tagName": "NodeAvailabilitySet" }
		],
		"unmanagedAvailabilitySetSku": "Classic",
		"managedAvailabilitySetSku": "Aligned",
		"availabilitySetSku": "[concat(parameters('storageKind'), 'AvailabilitySetSku')]",
		"unmanagedPlatformFaultDomainCount": 3,
		"managedPlatformFaultDomainCount": 2,
		"platformFaultDomainCount": "[concat(parameters('storageKind'), 'PlatformFaultDomainCount')]",
		"storageSkuObject": {
			"master": {
				"skuName": "[variables('vmSizesMap')[parameters('masterVmSize')].storageAccountType]",
				"skuTier": "[variables('vmSizesMap')[parameters('masterVmSize')].storageAccountTier]"
			},
			"infra": {
				"skuName": "[variables('vmSizesMap')[parameters('infraVmSize')].storageAccountType]",
				"skuTier": "[variables('vmSizesMap')[parameters('infraVmSize')].storageAccountTier]"
			},
			"node": {
				"skuName": "[variables('vmSizesMap')[parameters('nodeVmSize')].storageAccountType]",
				"skuTier": "[variables('vmSizesMap')[parameters('nodeVmSize')].storageAccountTier]"
			},
			"diagnostics": {
				"skuName": "Standard_LRS",
				"skuTier": "Standard"
			},
			"registry": {
				"skuName": "Standard_LRS",
				"skuTier": "Standard"
			},
			"persistent": {
				"skuName": "Standard_LRS",
				"skuTier": "Standard"
			}
		},
		"managedStorageCount": 3,
		"unmanagedStorageCount": "[length(variables('newStorageAccountArray'))]",
		"storageLoopCount": "[concat(parameters('storageKind'), 'StorageCount')]",
		"unmanagedMasterUri": "[variables('newStorageAccountMaster')]",
		"managedMasterUri": "[variables('diagStorageAccount1')]",
		"unmanagedInfraUri": "[variables('newStorageAccountInfra')]",
		"managedInfraUri": "[variables('diagStorageAccount1')]",
		"unmanagedNodeOsUri": "[variables('newStorageAccountNodeOs')]",
		"managedNodeOsUri": "[variables('diagStorageAccount1')]",
		"unmanagedNodeDataUri": "[variables('newStorageAccountNodeData')]",
		"managedNodeDataUri": "[variables('diagStorageAccount1')]",
		"masterUri": "[concat(parameters('storageKind'), 'MasterUri')]",
		"infraUri": "[concat(parameters('storageKind'), 'InfraUri')]",
		"nodeOsUri": "[concat(parameters('storageKind'), 'NodeOsUri')]",
		"nodeDataUri": "[concat(parameters('storageKind'), 'NodeDataUri')]",
		"virtualNetworkName": "openshiftvnet",
		"masterSubnetName": "mastersubnet",
		"nodeSubnetName": "nodesubnet",

		"masterLoadBalancerName": "[concat(variables('openshiftMasterHostname'), 'lb')]",
		"masterPublicIpAddressId": "[resourceId('Microsoft.Network/publicIPAddresses', variables('openshiftMasterPublicIpDnsLabel'))]",
		"masterLbId": "[resourceId('Microsoft.Network/loadBalancers', variables('masterLoadBalancerName'))]",
		"masterLbFrontEndConfigId": "[concat(variables('masterLbId'), '/frontendIPConfigurations/loadBalancerFrontEnd')]",
		"masterLbBackendPoolId": "[concat(variables('masterLbId'),'/backendAddressPools/loadBalancerBackend')]",
		"masterLbHttpProbeId": "[concat(variables('masterLbId'),'/probes/httpProbe')]",
		"masterLbHttpsProbeId": "[concat(variables('masterLbId'),'/probes/httpsProbe')]",

		"infraLoadBalancerName": "[concat(variables('openshiftInfraHostname'), 'lb')]",
		"infraPublicIpAddressId": "[resourceId('Microsoft.Network/publicIPAddresses', variables('infraLbPublicIpDnsLabel'))]",
		"infraLbId": "[resourceId('Microsoft.Network/loadBalancers', variables('infraLoadBalancerName'))]",
		"infraLbFrontEndConfigId": "[concat(variables('infraLbId'), '/frontendIPConfigurations/loadBalancerFrontEnd')]",
		"infraLbBackendPoolId": "[concat(variables('infraLbId'),'/backendAddressPools/loadBalancerBackend')]",
		"infraLbHttpProbeId": "[concat(variables('infraLbId'),'/probes/httpProbe')]",
		"infraLbHttpsProbeId": "[concat(variables('infraLbId'),'/probes/httpsProbe')]",
		"imageReference": {
			"publisher": "Openlogic",
			"offer": "CentOS",
			"sku": "7.5",
			"version": "latest"
		},
		"redHatTags": {
			"app": "OpenShiftOrigin",
			"version": "3.9",
			"platform": "AzurePublic",
			"provider": "9d2c71fc-96ba-4b4a-93b3-14def5bc96fc"
		},
		"singlequote": "'",
		"sshKeyPath": "[concat('/home/', parameters('adminUsername'), '/.ssh/authorized_keys')]",
		"nodePrepScriptUrl": "[concat(parameters('_artifactsLocation'), '/scripts/nodePrep.sh')]",
		"masterPrepScriptUrl": "[concat(parameters('_artifactsLocation'), '/scripts/masterPrep.sh')]",
		"openshiftDeploymentScriptUrl": "[concat(parameters('_artifactsLocation'), '/scripts/deployOpenShift.sh')]",
		"nodePrepScriptFileName": "nodePrep.sh",
		"masterPrepScriptFileName": "masterPrep.sh",
		"openshiftDeploymentScriptFileName": "deployOpenShift.sh",
		"clusterNodeDeploymentTemplateUrl": "[concat(parameters('_artifactsLocation'), '/nested/clusternode.json')]",
		"openshiftDeploymentTemplateUrl": "[concat(parameters('_artifactsLocation'), '/nested/openshiftdeploy.json')]",
		"vmSizesMap": {
			"Standard_A4": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_A5": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_A6": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_A7": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_A8": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_A9": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_A10": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_A11": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D1": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D2": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D3": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D4": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D11": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D12": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D13": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D14": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D1_v2": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D2_v2": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D3_v2": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D4_v2": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D5_v2": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D11_v2": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D12_v2": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D13_v2": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D14_v2": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_G1": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_G2": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_G3": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_G4": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_G5": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_DS1": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS2": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS3": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS4": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS11": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS12": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS13": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS14": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS1_v2": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS2_v2": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS3_v2": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS4_v2": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS5_v2": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS11_v2": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS12_v2": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS13_v2": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS14_v2": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_DS15_v2": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_GS1": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_GS2": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_GS3": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_GS4": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_GS5": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_D2_v3": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D4_v3": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D8_v3": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D16_v3": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D32_v3": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D64_v3": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_D2s_v3": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_D4s_v3": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_D8s_v3": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_D16s_v3": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_D32s_v3": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_D64s_v3": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_E2_v3": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_E4_v3": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_E8_v3": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_E16_v3": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_E32_v3": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_E64_v3": {
				"storageAccountType": "Standard_LRS",
				"storageAccountTier": "Standard"
			},
			"Standard_E2s_v3": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_E4s_v3": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_E8s_v3": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_E16s_v3": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_E32s_v3": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			},
			"Standard_E64s_v3": {
				"storageAccountType": "Premium_LRS",
				"storageAccountTier": "Premium"
			}
		}
	},
	"resources": [
		{
			"apiVersion": "[variables('apiVersionNetwork')]",
			"type": "Microsoft.Network/networkSecurityGroups",
			"name": "[concat(variables('openshiftMasterHostname'), '-nsg')]",
			"location": "[variables('location')]",
			"tags": {
				"displayName": "MasterNSG",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"

			},
			"properties": {
				"securityRules": [{
					"name": "allowSSHin_all",
					"properties": {
						"description": "Allow SSH in from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "22",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 100,
						"direction": "Inbound"
					}
				}, {
					"name": "allowHTTPS_all",
					"properties": {
						"description": "Allow HTTPS connections from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "443",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 200,
						"direction": "Inbound"
					}
				}]
			}
		}, {
			"apiVersion": "[variables('apiVersionNetwork')]",
			"type": "Microsoft.Network/networkSecurityGroups",
			"name": "[concat(variables('openshiftInfraHostname'), '-nsg')]",
			"location": "[variables('location')]",
			"tags": {
				"displayName": "InfraNSG",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"
			},
			"properties": {
				"securityRules": [{
					"name": "allowSSHin_all",
					"properties": {
						"description": "Allow SSH in from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "22",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 100,
						"direction": "Inbound"
					}
				}, {
					"name": "allowHTTPSIn_all",
					"properties": {
						"description": "Allow HTTPS connections from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "443",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 200,
						"direction": "Inbound"
					}
				}, {
					"name": "allowHTTPIn_all",
					"properties": {
						"description": "Allow HTTP connections from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "80",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 300,
						"direction": "Inbound"
					}
				}]
			}
		}, {
			"apiVersion": "[variables('apiVersionNetwork')]",
			"type": "Microsoft.Network/networkSecurityGroups",
			"name": "[concat(variables('openshiftNodeHostname'), '-nsg')]",
			"location": "[variables('location')]",
			"tags": {
				"displayName": "NodeNSG",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"
			},
			"properties": {
				"securityRules": [{
					"name": "allowSSHin_all",
					"properties": {
						"description": "Allow SSH in from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "22",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 100,
						"direction": "Inbound"
					}
				}, {
					"name": "allowHTTPS_all",
					"properties": {
						"description": "Allow HTTPS connections from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "443",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 200,
						"direction": "Inbound"
					}
				}, {
					"name": "allowHTTPIn_all",
					"properties": {
						"description": "Allow HTTP connections from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "80",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 300,
						"direction": "Inbound"
					}
				}]
			}
		}, {
			"type": "Microsoft.Network/virtualNetworks",
			"name": "[variables('virtualNetworkName')]",
			"location": "[variables('location')]",
			"tags": {
				"displayName": "VirtualNetwork",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"
			},
			"apiVersion": "[variables('apiVersionNetwork')]",
			"properties": {
				"addressSpace": {
					"addressPrefixes": [
						"[variables('addressPrefix')]"
					]
				},
				"subnets": [{
					"name": "[variables('masterSubnetName')]",
					"properties": {
						"addressPrefix": "[variables('masterSubnetPrefix')]"
					}
				}, {
					"name": "[variables('nodeSubnetName')]",
					"properties": {
						"addressPrefix": "[variables('nodeSubnetPrefix')]"
					}
				}]
			}
		}, {
			"type": "Microsoft.Storage/storageAccounts",
			"name": "[variables('newStorageAccountArray')[copyIndex()].name]",
			"location": "[variables('location')]",
			"kind": "Storage",
			"apiVersion": "[variables('apiVersionStorage')]",
			"tags": {
				"displayName": "[variables('newStorageAccountArray')[copyIndex()].tagName]",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"
			},
			"copy": {
				"name": "storageLoop",
				"count": "[variables(variables('storageLoopCount'))]"
			},
			"sku": {
				"name": "[variables('newStorageAccountArray')[copyIndex()].skuName]",
				"tier": "[variables('newStorageAccountArray')[copyIndex()].skuTier]"
			}
		}, {
			"type": "Microsoft.Network/publicIPAddresses",
			"name": "[variables('infraLbPublicIpDnsLabel')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionNetwork')]",
			"tags": {
				"displayName": "OpenShiftInfraLBPublicIP",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"
			},
			"properties": {
				"publicIPAllocationMethod": "Static",
				"dnsSettings": {
					"domainNameLabel": "[variables('infraLbPublicIpDnsLabel')]"
				}
			}
		}, {
			"type": "Microsoft.Network/publicIPAddresses",
			"name": "[variables('openshiftMasterPublicIpDnsLabel')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionNetwork')]",
			"tags": {
				"displayName": "OpenShiftMasterPublicIP",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"
			},
			"properties": {
				"publicIPAllocationMethod": "Static",
				"dnsSettings": {
					"domainNameLabel": "[variables('openshiftMasterPublicIpDnsLabel')]"
				}
			}
		}, {
			"type": "Microsoft.Compute/availabilitySets",
			"name": "[variables('availabilitySetArray')[copyIndex()].name]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionCompute')]",
            "sku": {
				"name": "[variables(variables('availabilitySetSku'))]"
			},
			"properties": {
				"platformFaultDomainCount": "[variables(variables('platformFaultDomainCount'))]",
                "platformUpdateDomainCount": "5"
			},
			"tags": {
				"displayName": "[variables('availabilitySetArray')[copyIndex()].tagName]",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"
			},
			"copy": {
				"name": "availabiltySetLoop",
				"count": "[length(variables('availabilitySetArray'))]"
			}
		}, {
			"type": "Microsoft.Network/loadBalancers",
			"name": "[variables('masterLoadBalancerName')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionNetwork')]",
			"tags": {
				"displayName": "OpenShiftMasterLB",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"
			},
			"dependsOn": [
				"[concat('Microsoft.Network/publicIPAddresses/', variables('openshiftMasterPublicIpDnsLabel'))]"
			],
			"properties": {
				"frontendIPConfigurations": [{
					"name": "LoadBalancerFrontEnd",
					"properties": {
						"publicIPAddress": {
							"id": "[variables('masterPublicIpAddressId')]"
						}
					}
				}],
				"backendAddressPools": [{
					"name": "loadBalancerBackEnd"
				}],
				"loadBalancingRules": [{
					"name": "OpenShiftAdminConsole",
					"properties": {
						"frontendIPConfiguration": {
							"id": "[variables('masterLbFrontEndConfigId')]"
						},
						"backendAddressPool": {
							"id": "[variables('masterLbBackendPoolId')]"
						},
						"protocol": "Tcp",
						"loadDistribution": "SourceIP",
						"idleTimeoutInMinutes": 30,
						"frontendPort": 443,
						"backendPort": 443,
						"probe": {
							"id": "[variables('masterLbHttpsProbeId')]"
						}
					}
				}],
				"probes": [{
					"name": "httpsProbe",
					"properties": {
						"protocol": "Tcp",
						"port": 443,
						"intervalInSeconds": 5,
						"numberOfProbes": 2
					}
				}]
			}
		},
		{
			"apiVersion": "[variables('apiVersionNetwork')]",
			"type": "Microsoft.Network/loadBalancers/inboundNatRules",
			"name": "[concat(variables('masterLoadBalancerName'), '/', 'SSH-', variables('openshiftMasterHostname'), copyIndex())]",
			"location": "[variables('location')]",
			"copy": {
				"name": "masterLbLoop",
				"count": "[variables('masterInstanceCount')]"
			},
			"dependsOn": [
				"[variables('masterLbId')]"
			],
			"properties": {
				"frontendIPConfiguration": {
					"id": "[variables('masterLbFrontEndConfigId')]"
				},
				"protocol": "tcp",
				"frontendPort": "[copyIndex(2200)]",
				"backendPort": 22,
				"enableFloatingIP": false
			}
		},
		{
			"type": "Microsoft.Network/loadBalancers",
			"name": "[variables('infraLoadBalancerName')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionNetwork')]",
			"tags": {
				"displayName": "OpenShiftInfraLB",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"
			},
			"dependsOn": [
				"[concat('Microsoft.Network/publicIPAddresses/', variables('infraLbPublicIpDnsLabel'))]"
			],
			"properties": {
				"frontendIPConfigurations": [{
					"name": "LoadBalancerFrontEnd",
					"properties": {
						"publicIPAddress": {
							"id": "[variables('infraPublicIpAddressId')]"
						}
					}
				}],
				"backendAddressPools": [{
					"name": "loadBalancerBackEnd"
				}],
				"loadBalancingRules": [{
					"name": "OpenShiftRouterHTTP",
					"properties": {
						"frontendIPConfiguration": {
							"id": "[variables('infraLbFrontEndConfigId')]"
						},
						"backendAddressPool": {
							"id": "[variables('infraLbBackendPoolId')]"
						},
						"protocol": "Tcp",
						"frontendPort": 80,
						"backendPort": 80,
						"probe": {
							"id": "[variables('infraLbHttpProbeId')]"
						}
					}
				}, {
					"name": "OpenShiftRouterHTTPS",
					"properties": {
						"frontendIPConfiguration": {
							"id": "[variables('infraLbFrontEndConfigId')]"
						},
						"backendAddressPool": {
							"id": "[variables('infraLbBackendPoolId')]"
						},
						"protocol": "Tcp",
						"frontendPort": 443,
						"backendPort": 443,
						"probe": {
							"id": "[variables('infraLbHttpsProbeId')]"
						}
					}
				}],
				"probes": [{
					"name": "httpProbe",
					"properties": {
						"protocol": "Tcp",
						"port": 80,
						"intervalInSeconds": 5,
						"numberOfProbes": 2
					}
				}, {
					"name": "httpsProbe",
					"properties": {
						"protocol": "Tcp",
						"port": 443,
						"intervalInSeconds": 5,
						"numberOfProbes": 2
					}
				}]
			}
		}, {
			"type": "Microsoft.Network/networkInterfaces",
			"name": "[concat(variables('openshiftMasterHostname'), '-', copyIndex(), '-nic')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionNetwork')]",
			"tags": {
				"displayName": "OpenShiftMasterNetworkInterface",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"
			},
			"dependsOn": [
				"[concat('Microsoft.Network/virtualNetworks/', variables('virtualNetworkName'))]",
				"[concat('Microsoft.Network/loadBalancers/', variables('masterLoadBalancerName'))]",
				"[concat(variables('masterLbId'), '/inboundNatRules/SSH-', variables('openshiftMasterHostname') ,copyIndex())]",
				"[concat('Microsoft.Network/networkSecurityGroups/', variables('openshiftMasterHostname'), '-nsg')]"
			],
			"copy": {
				"name": "masterNicLoop",
				"count": "[variables('masterInstanceCount')]"
			},
			"properties": {
				"ipConfigurations": [{
					"name": "[concat(variables('openshiftMasterHostname'), copyIndex(), 'ipconfig')]",
					"properties": {
						"privateIPAllocationMethod": "Dynamic",
						"subnet": {
							"id": "[concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', resourceGroup().name, '/providers/Microsoft.Network/virtualNetworks/', variables('virtualNetworkName'), '/subnets/', variables('masterSubnetName'))]"
						},
						"loadBalancerBackendAddressPools": [{
							"id": "[concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', resourceGroup().name, '/providers/Microsoft.Network/loadBalancers/', variables('masterLoadBalancerName'), '/backendAddressPools/loadBalancerBackEnd')]"
						}],
						"loadBalancerInboundNatRules": [
							{
								"id": "[concat(variables('masterLbId'),'/inboundNatRules/SSH-', variables('openshiftMasterHostname'), copyIndex())]"
							}
						]
					}
				}],
				"networkSecurityGroup": {
					"id": "[resourceId('Microsoft.Network/networkSecurityGroups', concat(variables('openshiftMasterHostname'), '-nsg'))]"
				}
			}
		}, {
			"type": "Microsoft.Network/networkInterfaces",
			"name": "[concat(variables('openshiftInfraHostname'), '-', copyIndex(), '-nic')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionNetwork')]",
			"tags": {
				"displayName": "OpenShiftInfraNetworkInterfaces",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"
			},
			"dependsOn": [
				"[concat('Microsoft.Network/virtualNetworks/', variables('virtualNetworkName'))]",
				"[concat('Microsoft.Network/loadBalancers/', variables('infraLoadBalancerName'))]",
				"[concat('Microsoft.Network/networkSecurityGroups/', variables('openshiftInfraHostname'), '-nsg')]"
			],
			"copy": {
				"name": "infraNicLoop",
				"count": "[variables('infraInstanceCount')]"
			},
			"properties": {
				"ipConfigurations": [{
					"name": "[concat(variables('openshiftInfraHostname'), copyIndex(), 'ipconfig')]",
					"properties": {
						"privateIPAllocationMethod": "Dynamic",
						"subnet": {
							"id": "[concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', resourceGroup().name, '/providers/Microsoft.Network/virtualNetworks/', variables('virtualNetworkName'), '/subnets/', variables('masterSubnetName'))]"
						},
						"loadBalancerBackendAddressPools": [{
							"id": "[concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', resourceGroup().name, '/providers/Microsoft.Network/loadBalancers/', variables('infraLoadBalancerName'), '/backendAddressPools/loadBalancerBackEnd')]"
						}]
					}
				}],
				"networkSecurityGroup": {
					"id": "[resourceId('Microsoft.Network/networkSecurityGroups', concat(variables('openshiftInfraHostname'), '-nsg'))]"
				}
			}
		}, {
			"type": "Microsoft.Network/networkInterfaces",
			"name": "[concat(variables('openshiftNodeHostname'), '-', copyIndex(), '-nic')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionNetwork')]",
			"tags": {
				"displayName": "OpenShiftNodeNetworkInterfaces",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"
			},
			"dependsOn": [
				"[concat('Microsoft.Network/virtualNetworks/', variables('virtualNetworkName'))]",
				"[concat('Microsoft.Network/networkSecurityGroups/', variables('openshiftNodeHostname'), '-nsg')]"
			],
			"copy": {
				"name": "nodeNicLoop",
				"count": "[variables('nodeInstanceCount')]"
			},
			"properties": {
				"ipConfigurations": [{
					"name": "[concat(variables('openshiftNodeHostname'), copyIndex(), 'ipconfig')]",
					"properties": {
						"privateIPAllocationMethod": "Dynamic",
						"subnet": {
							"id": "[concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', resourceGroup().name, '/providers/Microsoft.Network/virtualNetworks/', variables('virtualNetworkName'), '/subnets/', variables('nodeSubnetName'))]"
						}
					}
				}],
				"networkSecurityGroup": {
					"id": "[resourceId('Microsoft.Network/networkSecurityGroups', concat(variables('openshiftNodeHostname'), '-nsg'))]"
				}
			}
		}, {
			"name": "[concat('masterVmDeployment', copyindex())]",
			"type": "Microsoft.Resources/deployments",
			"apiVersion": "[variables('apiVersionLinkTemplate')]",
			"dependsOn": [
				"[resourceId('Microsoft.Storage/storageAccounts', variables('diagStorageAccount1'))]",
				"masterNicLoop",
				"masteravailabilityset"
			],
			"copy": {
				"name": "masterVmLoop",
				"count": "[variables('masterInstanceCount')]"
			},
			"properties": {
				"mode": "Incremental",
				"templateLink": {
					"uri": "[variables('clusterNodeDeploymentTemplateUrl')]",
					"contentVersion": "1.0.0.0"
				},
				"parameters": {
					"location": {
						"value": "[variables('location')]"
					},
					"sshKeyPath": {
						"value": "[variables('sshKeyPath')]"
					},
					"sshPublicKey": {
						"value": "[parameters('sshPublicKey')]"
					},
					"dataDiskSize": {
						"value": "[variables('dataDiskSize')]"
					},
					"adminUsername": {
						"value": "[parameters('adminUsername')]"
					},
					"vmSize": {
						"value": "[parameters('masterVmSize')]"
					},
					"availabilitySet": {
						"value": "masteravailabilityset"
					},
					"hostname": {
						"value": "[concat(variables('openshiftMasterHostname'), '-', copyIndex())]"
					},
					"unmanagedOsDiskUri": {
						"value": "[reference(resourceId(resourceGroup().name, 'Microsoft.Storage/storageAccounts', variables(variables('masterUri'))), variables('apiVersionStorage')).primaryEndpoints['blob']]"
					},
					"unmanagedDataDiskUri": {
						"value": "[reference(resourceId(resourceGroup().name, 'Microsoft.Storage/storageAccounts', variables(variables('masterUri'))), variables('apiVersionStorage')).primaryEndpoints['blob']]"
					},
					"role": {
						"value": "masternode"
					},
					"vmStorageType": {
						"value": "[variables('vmSizesMap')[parameters('masterVmSize')].storageAccountType]"
					},
					"storageKind": {
						"value": "[parameters('storageKind')]"
					},
					"newStorageAccountOs": {
						"value": "[variables('newStorageAccountMaster')]"
					},
					"newStorageAccountData": {
						"value": "[variables('newStorageAccountMaster')]"
					},
					"diagStorageAccount": {
						"value": "[variables('diagStorageAccount1')]"
					},
					"apiVersionStorage": {
						"value": "[variables('apiVersionStorage')]"
					},
					"apiVersionCompute": {
						"value": "[variables('apiVersionCompute')]"
					},
					"imageReference": {
						"value": "[variables('imageReference')]"
					},
					"redHatTags": {
						"value": "[variables('redHatTags')]"
					}
				}
			}
		}, {
			"name": "[concat('infraVmDeployment', copyindex())]",
			"type": "Microsoft.Resources/deployments",
			"apiVersion": "[variables('apiVersionLinkTemplate')]",
			"dependsOn": [
				"[resourceId('Microsoft.Storage/storageAccounts', variables('diagStorageAccount1'))]",
				"infraNicLoop",
				"infraavailabilityset"
			],
			"copy": {
				"name": "infraVmLoop",
				"count": "[variables('infraInstanceCount')]"
			},
			"properties": {
				"mode": "Incremental",
				"templateLink": {
					"uri": "[variables('clusterNodeDeploymentTemplateUrl')]",
					"contentVersion": "1.0.0.0"
				},
				"parameters": {
					"location": {
						"value": "[variables('location')]"
					},
					"sshKeyPath": {
						"value": "[variables('sshKeyPath')]"
					},
					"sshPublicKey": {
						"value": "[parameters('sshPublicKey')]"
					},
					"dataDiskSize": {
						"value": "[variables('dataDiskSize')]"
					},
					"adminUsername": {
						"value": "[parameters('adminUsername')]"
					},
					"vmSize": {
						"value": "[parameters('infraVmSize')]"
					},
					"availabilitySet": {
						"value": "infraavailabilityset"
					},
					"hostname": {
						"value": "[concat(variables('openshiftInfraHostname'), '-', copyIndex())]"
					},
					"unmanagedOsDiskUri": {
						"value": "[reference(resourceId(resourceGroup().name, 'Microsoft.Storage/storageAccounts', variables(variables('infraUri'))), variables('apiVersionStorage')).primaryEndpoints['blob']]"
					},
					"unmanagedDataDiskUri": {
						"value": "[reference(resourceId(resourceGroup().name, 'Microsoft.Storage/storageAccounts', variables(variables('infraUri'))), variables('apiVersionStorage')).primaryEndpoints['blob']]"
					},
					"role": {
						"value": "infranode"
					},
					"vmStorageType": {
						"value": "[variables('vmSizesMap')[parameters('infraVmSize')].storageAccountType]"
					},
					"storageKind": {
						"value": "[parameters('storageKind')]"
					},
					"newStorageAccountOs": {
						"value": "[variables('newStorageAccountInfra')]"
					},
					"newStorageAccountData": {
						"value": "[variables('newStorageAccountInfra')]"
					},
					"diagStorageAccount": {
						"value": "[variables('diagStorageAccount1')]"
					},
					"apiVersionStorage": {
						"value": "[variables('apiVersionStorage')]"
					},
					"apiVersionCompute": {
						"value": "[variables('apiVersionCompute')]"
					},
					"imageReference": {
						"value": "[variables('imageReference')]"
					},
					"redHatTags": {
						"value": "[variables('redHatTags')]"
					}
				}
			}
		}, {
			"name": "[concat('nodeVmDeployment', copyindex())]",
			"type": "Microsoft.Resources/deployments",
			"apiVersion": "[variables('apiVersionLinkTemplate')]",
			"dependsOn": [
				"[resourceId('Microsoft.Storage/storageAccounts', variables('diagStorageAccount2'))]",
				"nodeNicLoop",
				"nodeavailabilityset"
			],
			"copy": {
				"name": "nodeVmLoop",
				"count": "[variables('nodeInstanceCount')]"
			},
			"properties": {
				"mode": "Incremental",
				"templateLink": {
					"uri": "[variables('clusterNodeDeploymentTemplateUrl')]",
					"contentVersion": "1.0.0.0"
				},
				"parameters": {
					"location": {
						"value": "[variables('location')]"
					},
					"sshKeyPath": {
						"value": "[variables('sshKeyPath')]"
					},
					"sshPublicKey": {
						"value": "[parameters('sshPublicKey')]"
					},
					"dataDiskSize": {
						"value": "[variables('dataDiskSize')]"
					},
					"adminUsername": {
						"value": "[parameters('adminUsername')]"
					},
					"vmSize": {
						"value": "[parameters('nodeVmSize')]"
					},
					"availabilitySet": {
						"value": "nodeavailabilityset"
					},
					"hostname": {
						"value": "[concat(variables('openshiftNodeHostname'), '-', copyIndex())]"
					},
					"unmanagedOsDiskUri": {
						"value": "[reference(resourceId(resourceGroup().name, 'Microsoft.Storage/storageAccounts', variables(variables('nodeOsUri'))), variables('apiVersionStorage')).primaryEndpoints['blob']]"
					},
					"unmanagedDataDiskUri": {
						"value": "[reference(resourceId(resourceGroup().name, 'Microsoft.Storage/storageAccounts', variables(variables('nodeDataUri'))), variables('apiVersionStorage')).primaryEndpoints['blob']]"
					},
					"role": {
						"value": "appnode"
					},
					"vmStorageType": {
						"value": "[variables('vmSizesMap')[parameters('nodeVmSize')].storageAccountType]"
					},
					"storageKind": {
						"value": "[parameters('storageKind')]"
					},
					"newStorageAccountOs": {
						"value": "[variables('newStorageAccountNodeOs')]"
					},
					"newStorageAccountData": {
						"value": "[variables('newStorageAccountNodeData')]"
					},
					"diagStorageAccount": {
						"value": "[variables('diagStorageAccount2')]"
					},
					"apiVersionStorage": {
						"value": "[variables('apiVersionStorage')]"
					},
					"apiVersionCompute": {
						"value": "[variables('apiVersionCompute')]"
					},
					"imageReference": {
						"value": "[variables('imageReference')]"
					},
					"redHatTags": {
						"value": "[variables('redHatTags')]"
					}
				}
			}
		}, {
			"type": "Microsoft.Compute/virtualMachines/extensions",
			"name": "[concat(variables('openshiftMasterHostname'), '-', copyIndex(), '/deployOpenShift')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionCompute')]",
			"tags": {
				"displayName": "PrepMaster",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"
			},
			"dependsOn": [
				"[concat('masterVmDeployment', copyindex())]"
			],
			"copy": {
				"name": "masterPrepLoop",
				"count": "[variables('masterInstanceCount')]"
			},
			"properties": {
				"publisher": "Microsoft.Azure.Extensions",
				"type": "CustomScript",
				"typeHandlerVersion": "2.0",
				"autoUpgradeMinorVersion": true,
				"settings": {
					"fileUris": [
						"[variables('masterPrepScriptUrl')]"
					]
				},
				"protectedSettings": {
					"commandToExecute": "[concat('bash ', variables('masterPrepScriptFileName'), ' ', variables('newStorageAccountPersistentVolume1'), ' ', parameters('adminUsername'), ' ', variables('location'))]"
				}
			}
		}, {
			"type": "Microsoft.Compute/virtualMachines/extensions",
			"name": "[concat(variables('openshiftInfraHostname'), '-', copyIndex(), '/prepNodes')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionCompute')]",
			"tags": {
				"displayName": "PrepInfra",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"
			},
			"dependsOn": [
				"[concat('infraVmDeployment', copyindex())]"
			],
			"copy": {
				"name": "infraPrepLoop",
				"count": "[variables('infraInstanceCount')]"
			},
			"properties": {
				"publisher": "Microsoft.Azure.Extensions",
				"type": "CustomScript",
				"typeHandlerVersion": "2.0",
				"autoUpgradeMinorVersion": true,
				"settings": {
					"fileUris": [
						"[variables('nodePrepScriptUrl')]"
					]
				},
				"protectedSettings": {
					"commandToExecute": "[concat('bash ', variables('nodePrepScriptFileName'))]"
				}
			}
		}, {
			"type": "Microsoft.Compute/virtualMachines/extensions",
			"name": "[concat(variables('openshiftNodeHostname'), '-', copyIndex(), '/prepNodes')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionCompute')]",
			"tags": {
				"displayName": "PrepNodes",
				"provider": "[variables('redHatTags').provider]",
				"app": "[variables('redHatTags').app]",
				"version": "[variables('redHatTags').version]",
				"platform": "[variables('redHatTags').platform]"
			},
			"dependsOn": [
				"[concat('nodeVmDeployment', copyindex())]"
			],
			"copy": {
				"name": "nodePrepLoop",
				"count": "[variables('nodeInstanceCount')]"
			},
			"properties": {
				"publisher": "Microsoft.Azure.Extensions",
				"type": "CustomScript",
				"typeHandlerVersion": "2.0",
				"autoUpgradeMinorVersion": true,
				"settings": {
					"fileUris": [
						"[variables('nodePrepScriptUrl')]"
					]
				},
				"protectedSettings": {
					"commandToExecute": "[concat('bash ', variables('nodePrepScriptFileName'))]"
				}
			}
		}, {
			"name": "OpenShiftDeployment",
			"type": "Microsoft.Resources/deployments",
			"apiVersion": "[variables('apiVersionLinkTemplate')]",
			"dependsOn": [
				"[resourceId('Microsoft.Storage/storageAccounts', variables('newStorageAccountRegistry'))]",
				"masterPrepLoop",
				"infraPrepLoop",
				"nodePrepLoop"
			],
			"properties": {
				"mode": "Incremental",
				"templateLink": {
					"uri": "[variables('openshiftDeploymentTemplateUrl')]",
					"contentVersion": "1.0.0.0"
				},
				"parameters": {
					"_artifactsLocation": {
						"value": "[parameters('_artifactsLocation')]"
					},
					"apiVersionCompute": {
						"value": "[variables('apiVersionCompute')]"
					},
					"openshiftDeploymentScriptUrl": {
						"value": "[variables('openshiftDeploymentScriptUrl')]"
					},
					"openshiftDeploymentScriptFileName": {
						"value": "[variables('openshiftDeploymentScriptFileName')]"
					},
					"newStorageAccountRegistry": {
						"value": "[variables('newStorageAccountRegistry')]"
					},
					"newStorageAccountKey": {
						"value": "[listKeys(variables('newStorageAccountRegistry'), variables('apiVersionStorage')).keys[0].value]"
					},
					"openshiftMasterHostname": {
						"value": "[variables('openshiftMasterHostname')]"
					},
					"openshiftMasterPublicIpFqdn": {
						"value": "[reference(variables('openshiftMasterPublicIpDnsLabel')).dnsSettings.fqdn]"
					},
					"openshiftMasterPublicIpAddress": {
						"value": "[reference(variables('openshiftMasterPublicIpDnsLabel')).ipAddress]"
					},
					"openshiftInfraHostname": {
						"value": "[variables('openshiftInfraHostname')]"
					},
					"openshiftNodeHostname": {
						"value": "[variables('openshiftNodeHostname')]"
					},
					"masterInstanceCount": {
						"value": "[variables('masterInstanceCount')]"
					},
					"infraInstanceCount": {
						"value": "[variables('infraInstanceCount')]"
					},
					"nodeInstanceCount": {
						"value": "[variables('nodeInstanceCount')]"
					},
					"storageKind": {
						"value": "[parameters('storageKind')]"
					},
					"adminUsername": {
						"value": "[parameters('adminUsername')]"
					},
					"openshiftPassword": {
						"value": "[parameters('openshiftPassword')]"
					},
					"enableMetrics": {
						"value": "[parameters('enableMetrics')]"
					},
					"enableLogging": {
						"value": "[parameters('enableLogging')]"
					},
					"enableAzure": {
						"value": "[parameters('enableAzure')]"
					},
					"aadClientId": {
						"value": "[parameters('aadClientId')]"
					},
					"aadClientSecret": {
						"value": "[parameters('aadClientSecret')]"
					},
					"nipioDomain": {
						"value": "[concat(reference(variables('infraLbPublicIpDnsLabel')).ipAddress, '.nip.io')]"
					},
					"customDomain": {
						"value": "[variables('defaultSubDomain')]"
					},
					"subDomainChosen": {
						"value": "[concat(parameters('defaultSubDomainType'), 'Domain')]"
					},
					"redHatTags": {
						"value": "[variables('redHatTags')]"
					},
					"sshPrivateKey": {
						"reference": {
							"keyvault": {
								"id": "[concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', parameters('keyVaultResourceGroup'), '/providers/Microsoft.KeyVault/vaults/', parameters('keyVaultName'))]"
							},
							"secretName": "[parameters('keyVaultSecret')]"
						}
					}
				}
			}
		}
	],
	"outputs": {
		"OpenShift Console Url": {
			"type": "string",
			"value": "[concat('https://', reference(variables('openshiftMasterPublicIpDnsLabel')).dnsSettings.fqdn, '/console')]"
		},
		"OpenShift Master SSH": {
			"type": "string",
			"value": "[concat('ssh -p 2200 ', parameters('adminUsername'), '@', reference(variables('openshiftMasterPublicIpDnsLabel')).dnsSettings.fqdn)]"
		},
		"OpenShift Infra Load Balancer FQDN": {
			"type": "string",
			"value": "[reference(variables('infraLbPublicIpDnsLabel')).dnsSettings.fqdn]"
		}
	}
}
  DEPLOY

  parameters {
    "_artifactsLocation"              = "${var._artifactsLocation}"
    "masterVmSize"                    = "${var.masterVmSize}"
    "infraVmSize"                     = "${var.infraVmSize}"
    "nodeVmSize"                      = "${var.nodeVmSize}"
    "storageKind"                     = "${var.storageKind}"
    "openshiftClusterPrefix"          = "${var.openshiftClusterPrefix}"
    "masterInstanceCount"             = "${var.masterInstanceCount}"
    "infraInstanceCount"              = "${var.infraInstanceCount}"
    "nodeInstanceCount"               = "${var.nodeInstanceCount}"
    "dataDiskSize"                    = "${var.dataDiskSize}"
    "adminUsername"                   = "${var.adminUsername}"
    "openshiftPassword"               = "${var.openshiftPassword}"
    "enableMetrics"                   = "${var.enableMetrics}"
    "enableLogging"                   = "${var.enableLogging}"
    "sshPublicKey"                    = "${var.sshPublicKey}"
    "keyVaultResourceGroup"           = "${var.keyVaultResourceGroup}"
    "keyVaultName"                    = "${var.keyVaultName}"
    "keyVaultSecret"                  = "${var.keyVaultSecret}"
    "enableAzure"                     = "${var.enableAzure}"
    "aadClientId"                     = "${var.aadClientId}"
    "aadClientSecret"                 = "${var.aadClientSecret}"
    "defaultSubDomainType"            = "${var.defaultSubDomainType}"
    "addressPrefix"                   = "${var.addressPrefix}"
    "masterSubnetPrefix"              = "${var.masterSubnetPrefix}"
    "nodeSubnetPrefix"                = "${var.nodeSubnetPrefix}"
    "infraLbPublicIpDnsLabel"         = "${var.infraLbPublicIpDnsLabel}"
    "openshiftMasterPublicIpDnsLabel" = "${var.openshiftMasterPublicIpDnsLabel}"
  }

  deployment_mode = "Incremental"
}
