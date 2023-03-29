# Define provider for Azure
provider "azurerm" {
 features {}
}

# Create resource group
resource "azurerm_resource_group" "rg" {
  name = "my-resource-group"
  location = "eastus"
}
# Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name = "my-virtual-network"
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
# Create subnets
resource "azurerm_subnet" "web_subnet" {
  name = "web-subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix = "10.0.1.0/24"
}
resource "azurerm_subnet" "api_subnet" {
  name = "api-subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix = "10.0.2.0/24"
}
resource "azurerm_subnet" "db_subnet" {
  name = "db-subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix = "10.0.3.0/24"
}
# Create network security groups
resource "azurerm_network_security_group" "web_nsg" {
  name = "web-nsg"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
     security_rule {
        name = "http-rule"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "80"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }
}
resource "azurerm_network_security_group" "api_nsg" {
  name = "api-nsg"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
       security_rule {
         name = "http-rule"
         priority = 100
         direction = "Inbound"
         access = "Allow"
         protocol = "Tcp"
         source_port_range = "*"
         destination_port_range = "3000"
         source_address_prefix = "*"
         destination_address_prefix = "*"
        }
}
resource "azurerm_network_security_group" "db_nsg" {
  name = "db-nsg"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
    security_rule {
      name = "mysql-rule"
      priority = 100
      direction = "Inbound"
      access = "Allow" 
      protocol = "Tcp"
      source_port_range = "*"
      destination_port_range = "3306"
      source_address_prefix = "*"
      destination_address_prefix = "*"
    }
}
# Create network interfaces
resource "azurerm_network_interface" "web_nic" {
   name = "web-nic"
   location = 
}
