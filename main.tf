provider "azurerm" {
  version = "~>2.0.0"
  features {}
}
resource "azurerm_resource_group" "chanrgaks" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_kubernetes_cluster" "chanaks" {
  name                = "chanaks007"
  location            = azurerm_resource_group.chanrgaks.location
  resource_group_name = azurerm_resource_group.chanrgaks.name
  dns_prefix          = "chanrgaks1"

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = "Standard_D2_v2"
    vnet_subnet_id = azurerm_subnet.chan-subnet01.id
  }

 linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file("${path.module}/azure_rsa.pub")
    }
  }

    network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    load_balancer_sku = "standard"
  }

    service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    Environment = "Production"
  }
}
