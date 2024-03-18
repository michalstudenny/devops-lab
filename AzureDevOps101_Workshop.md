Microsoft Azure DevOps 101 Workshop. Your first Pipeline in Azure DevOps - Workshop (IaaC Terraform deployment in Azure).

Objective: Deploy your own fully functioning infrastructure in the Cloud using Azure Pipeline and Terraform.

Laboratory Instructions:


1. Log into Azure using CLI

Run the following command:

az login --tenant <YOUR_TENANT_ID>

A tenant represents an organization. It's a dedicated instance of Microsoft Entra ID.


2. Create the service principal name (SPN) and client secret
An Azure service principal is an identity created for use with applications, hosted services, and automated tools to access Azure resources.
This access is restricted by the roles assigned to the service principal, giving you control over which resources can be accessed and at which level.

Run the following command:

az ad sp create-for-rbac --name AzureDevOpsLab --role="Contributor" --scope "/subscriptions/<YOUR_SUBSCRIPTION_ID>"


# IMPORTANT! Copy the following values for later: appID; password; tenant


3. Create the Azure Resource Group and resources
A resource group is a container that holds related resources for an Azure solution.

Run the following command:

az group create --name AzureDevOps --location "polandcentral"


4. Create the storage account
An Azure storage account contains all of your Azure Storage data objects.

Run the following command:

az storage account create --resource-group AzureDevOps --name sa01azuredevops --sku Standard_LRS --encryption-services blob


5. Get the storage account key
Storage account access keys provide full access to the configuration of a storage account, as well as the data. Always be careful to protect your access keys.

Run the following command:

az storage account keys list --resource-group AzureDevOps --account-name sa01azuredevops --query [0].value -o tsv


# IMPORTANT: Store the access key in the same spot as you stored the appid, password, and tenant earlier.


6. Create the storage container

Run the following command:

az storage container create --name container01-azuredevops --account-name sa01azuredevops --account-key "<YOUR_ACCOUNT_KEY>"


7. Create the Azure Key Vault
Azure Key Vault allows organizations to securely store and manage sensitive information, such as application secrets and cryptographic keys, in a way that is easily accessible to authorized users and applications.
This allows organizations to enhance their IT security and reduce the risk of data breaches.

Run the following command to create your Azure Key Vault:

az keyvault create -n keyvault-devops01 -g AzureDevops -l "polandcentral"


8. Add the storage account access key to Key Vault
When you create a storage account, Azure generates two 512-bit storage account access keys for that account.
These keys can be used to authorize access to data in your storage account via Shared Key authorization, or via SAS tokens that are signed with the shared key.

Run the following command:

az keyvault secret set --vault-name "keyvault-devops01" --name "sa01-azdo-accesskey" --value "<YOUR_STORAGE_ACCOUNT_ACCESS_KEY>"


9. Add the Service Principal Password to Key Vault

Run the following command:

az keyvault secret set --vault-name "keyvault-devops01" --name "spn-azuredevops-password" --value "<YOUR_SERVICE_PRINCIPAL_PASSWORD>"


10. Add the VM admin password to Key Vault

Run the following command:

az keyvault secret set --vault-name "keyvault-devops01" --name "vm-admin-password" --value "GlobalLogic2024#"


11. Allow the SPN access to Key Vault

Run the following command:

az keyvault set-policy --name "keyvault-devops01" --spn "<YOUR_SERVICE_PRINCIPAL>" --secret-permissions get list


12. Create the repository in Azure DevOps

Click your Project and select Repos. Click Initialize to create a blank repository.

13. Create the variable group in Azure DevOps

Run the following command:

az pipelines variable-group create --name "Terraform-BuildVariables" --authorize true --organization https://dev.azure.com/<YOUR_ORGANIZATION_NAME> --project "<YOUR_PROJECT_NAME>" --variables foo=bar

14. Connect the variable group to Key Vault

15. Add the Terraform code to our Azure DevOps repository. Add only Azure_DevOps folder.

-(Root)
–Azure_DevOps
—Terraform (terraform is a child folder of the folder Azure_DevOps)

In our Terraform folder, we will create two files:

main.tf
variables.tf

# Note: You can download all of source files and view the structure on my GitHub.

16. Install the Terraform Azure DevOps extension

17. Create Agent Pool in Azure DevOps (name: Self-Hosted)

18. Configure the Self Hosted Agent - VM (name: vm-self-hosted-agent)

Run the following commands:

ssh <LOGIN>@<VM IP ADDRESS>

sudo apt-get update

sudo apt-get install git

git --version

sudo apt-get -y install zip

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

mkdir myagent && cd myagent

wget https://vstsagentpackage.azureedge.net/agent/3.236.1/vsts-agent-linux-x64-3.236.1.tar.gz

tar zxvf vsts-agent-linux-x64-3.236.1.tar.gz

./config.sh

./run.sh

19. Create the environment DEV with approval condition

20. Create the Azure DevOps Pipeline and run pipeline. Use code from azure-pipeline.yml and change the required values


Good luck!