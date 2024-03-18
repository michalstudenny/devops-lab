variable "client_secret" {
    description = "Client Secret"
}

variable "tenant_id" {
    description = "Tenant ID"
}

variable "subscription_id" {
    description = "Subscription ID"
}

variable "client_id" {
    description = "Client ID"
}

variable "environment" {
    description = "The name of the environment"
    default = "dev"
}

variable "location" {
    description = "Azure location to use"
    default = "polandcentral"
}

variable "virtual_network" {
  description = "virtual network address space"
  default = "10.0.0.0/16"
}

variable "internal_subnet" {
    default = "10.0.2.0/24"
}

variable "office-WAN" {
    description = "The IP address that allow me RDP into my test enviornment"
    default = "90.70.234.8"
}

variable "vm_name" {
    description = "The name given to the VM"
    default = "vm-srv01"
}

variable "vm_size" {
  description = "The size of the VM"
  default = "Standard_B1s"
}

variable "storageimage_publisher" {
    description = "The OS image publisher"
    default = "MicrosoftWindowsServer"
}

variable "storageimage_offer" {
    description = "The OS image offer"
    default = "WindowsServer"
}

variable "storageimage_sku" {
    description = "The OS SKU"
    default = "2019-datacenter"
}

variable "storageimage_version" {
    description = "The OS image version"
    default = "latest"
}

variable "manageddisk_type" {
    description = "The managed disk type for the VM"
    default = "Standard_LRS"
}

variable "admin_username" {
    description = "The username for our first local user for the VM"
    default = "localuser"
}

variable "admin_password" {
    description = "The temporary password for our VM"
}
