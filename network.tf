resource "azurerm_virtual_network" "chanvnet" {
  name                = "${var.prefix}-vnet"
  location            = azurerm_resource_group.chanrgaks.location
  resource_group_name = azurerm_resource_group.chanrgaks.name
  address_space       = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "chan-subnet01" {
  name                 = "subnet01"
  virtual_network_name = azurerm_virtual_network.chanvnet.name
  resource_group_name  = azurerm_resource_group.chanrgaks.name
  address_prefix     = "10.10.1.0/24"
}

# resource "azurerm_subnet" "example-aci" {
#   name                 = "aci"
#   virtual_network_name = azurerm_virtual_network.example.name
#   resource_group_name  = azurerm_resource_group.example.name
#   address_prefixes     = ["10.10.3.0/24"]
# }

#   delegation {
#     name = "aciDelegation"
#     service_delegation {
#       name    = "Microsoft.ContainerInstance/containerGroups"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
