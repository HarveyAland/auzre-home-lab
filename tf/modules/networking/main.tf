#Resource group
resource "azurerm_resource_group" "homelabrg" {
  name = "labrg"
  location = var.location
}

resource "azurerm_virtual_network" "homenet" {
  name                = "hmnet"
  location            = var.location
  resource_group_name = var.rg
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_subnet" "managedsub" {
  name                 = "managedsub"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.homenet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "pip" {
  name                = "pubip"
  resource_group_name = var.rg
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard" 

  tags = {
    environment = "Production"
  }
}


resource "azurerm_network_interface" "nic" {
  name                = "homelab-nic"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "nic-config"
    subnet_id                     = azurerm_subnet.managedsub.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "sg"
  location            = var.location
  resource_group_name = var.rg
}

resource "azurerm_network_security_rule" "netrule" {
  name                        = "Allow-RDP-HomeIP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = var.hmip
  destination_address_prefix  = "*"
  resource_group_name         = var.rg
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_subnet_network_security_group_association" "assoc" {
  subnet_id                 = azurerm_subnet.managedsub.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

