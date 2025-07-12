module "resource_group" {
  source                  = "../Child_Module/azurerm_resource_group"
  resource_group_name     = "TodoappRG"
  resource_group_location = "West Europe"
}
module "resource_group" {
  source                  = "../Child_Module/azurerm_resource_group"
  resource_group_name     = "Todoapp54"
  resource_group_location = "Central India"
}
module "resource_group" {
  source                  = "../Child_Module/azurerm_resource_group"
  resource_group_name     = "RG551"
  resource_group_location = "Central India"
}
module "virtual_network" {
  source                              = "../Child_Module/azurerm_vitrual_network"
  virtual_network_name                = "TodoappVnet"
  vritual_network_address_space       = ["10.0.0.0/24"]
  virtual_network_location            = "West Europe"
  Virtual_network_resource_group_name = "TodoappRG"
  depends_on                          = [module.resource_group]
}
module "subnet" {
  source                      = "../Child_Module/azurerm_subnet"
  subnet_name                 = "TodoappFrontendSubnet"
  subnet_address_prefixes     = ["10.0.0.0/25"]
  subnet_virtual_network_name = "TodoappVnet"
  subnet_resource_group_name  = "TodoappRG"

}

module "subnet1" {
  source                      = "../Child_Module/azurerm_subnet"
  subnet_name                 = "TodoappBackendSubnet"
  subnet_address_prefixes     = ["10.0.0.128/25"]
  subnet_virtual_network_name = "TodoappVnet"
  subnet_resource_group_name  = "TodoappRG"

}
module "public_ip_frontend" {
  source                        = "../Child_Module/azurerm_public_ip"
  public_ip_name                = "TodoappPublicIPFrontend"
  public_ip_location            = "West Europe"
  public_ip_resource_group_name = "TodoappRG"
  public_ip_allocation_method   = "Static"
}
module "public_ip_backend" {
  source                        = "../Child_Module/azurerm_public_ip"
  public_ip_name                = "TodoappPublicIPBackend"
  public_ip_location            = "West Europe"
  public_ip_resource_group_name = "TodoappRG"
  public_ip_allocation_method   = "Static"
}
module "network_interface_card_Frontend" {
  source                                       = "../Child_Module/azurerm_network_Interface_card"
  network_interface_card_name                  = "TodoappNICFrontend"
  network_interface_card_location              = "West Europe"
  network_interface_card_resource_group_name   = "TodoappRG"
  network_interface_card_ip_configuration_name = "TodoappIPConfig"
  network_interface_subnet_id                  = "/subscriptions/6da16843-2652-4f6e-b550-b4d1a16b30a9/resourceGroups/TodoappRG/providers/Microsoft.Network/virtualNetworks/TodoappVnet/subnets/TodoappFrontendSubnet"
  network_interface_card_private_ip_address    = "Dynamic"
  network_interface_card_public_ip_address_id  = "/subscriptions/6da16843-2652-4f6e-b550-b4d1a16b30a9/resourceGroups/TodoappRG/providers/Microsoft.Network/publicIPAddresses/TodoappPublicIPFrontend"
}
module "network_interface_card_Backend" {
  source                                       = "../Child_Module/azurerm_network_Interface_card"
  network_interface_card_name                  = "TodoappNICBackend"
  network_interface_card_location              = "West Europe"
  network_interface_card_resource_group_name   = "TodoappRG"
  network_interface_card_ip_configuration_name = "TodoappIPConfig"
  network_interface_subnet_id                  = "/subscriptions/6da16843-2652-4f6e-b550-b4d1a16b30a9/resourceGroups/TodoappRG/providers/Microsoft.Network/virtualNetworks/TodoappVnet/subnets/TodoappBackendSubnet"
  network_interface_card_private_ip_address    = "Dynamic"
  network_interface_card_public_ip_address_id  = "/subscriptions/6da16843-2652-4f6e-b550-b4d1a16b30a9/resourceGroups/TodoappRG/providers/Microsoft.Network/publicIPAddresses/TodoappPublicIPBackend"
}
module "Todoappmssqlserver" {
  source                                  = "../Child_Module/azurerm_sql_server"
  sql_server_name                         = "todoappsqlserver1"
  sql_server_location                     = "Central India"
  sql_server_resource_group_name          = "Todo_app_RG1"
  sql_server_version                      = "12.0"
  sql_server_administrator_login          = "sqladmin"
  sql_server_administrator_login_password = "P@ssw0rd1234!"
}
module "Mssqldatabase" {
  source            = "../Child_Module/azurerm_sql_database"
  sql_database_name = "Todoappdb1"
  sql_server_id     = "/subscriptions/6da16843-2652-4f6e-b550-b4d1a16b30a9/resourceGroups/Todo_app_RG1/providers/Microsoft.Sql/servers/todoappsqlserver1"
  
}
module "virtual_machine" {
  source                              = "../Child_Module/azurerm_virtual_machine"
  virtual_machine_name                = "TodoappVMfrontend"
  virtual_machine_location            = "West Europe"
  virtual_machine_resource_group_name = "TodoappRG"
  virtual_machine_network_interface_id = ["/subscriptions/6da16843-2652-4f6e-b550-b4d1a16b30a9/resourceGroups/TodoappRG/providers/Microsoft.Network/networkInterfaces/TodoappNICFrontend"]
  virtual_machine_size                = "Standard_B1s"
  virtual_machine_publisher           = "Canonical"
  virtual_machine_offer               = "0001-com-ubuntu-server-jammy"
  virtual_machine_sku                 = "22_04-lts-gen2"
  virtual_machine_verison             = "latest"
  virtual_machine_os_disk_name        = "TodoappVMfrontend"
  admin_username                      = "frontenduser"
  admin_password                      = "P@ssw0rd1234!"
  virtual_machine_computer_name       = "TodoappVMfrontend"
}

module "virtual_machine1" {
  source                              = "../Child_Module/azurerm_virtual_machine"
  virtual_machine_name                = "TodoappVMbackend"
  virtual_machine_location            = "West Europe"
  virtual_machine_resource_group_name = "TodoappRG"
  virtual_machine_network_interface_id = ["/subscriptions/6da16843-2652-4f6e-b550-b4d1a16b30a9/resourceGroups/TodoappRG/providers/Microsoft.Network/networkInterfaces/TodoappNICBackend"]
  virtual_machine_size                = "Standard_B1s"
  virtual_machine_publisher           = "Canonical"
  virtual_machine_offer               = "0001-com-ubuntu-server-jammy"
  virtual_machine_sku                 = "22_04-lts-gen2"
  virtual_machine_verison             = "latest"
  virtual_machine_os_disk_name        = "TodoappVMbackend"
  admin_username                      = "backenduser"
  admin_password                      = "P@ssw0rd1234!"
  virtual_machine_computer_name       = "TodoappVMbackend"
}
