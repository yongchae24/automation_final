resource "azurerm_availability_set" "av_set" {
  name                         = "${var.humber_id}-linux-avset"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_update_domain_count = 5
  platform_fault_domain_count  = 3
}

resource "azurerm_public_ip" "public_ip" {
  for_each             = var.vm_names
  name                 = "${var.humber_id}-${each.key}-public-ip"
  location             = var.location
  resource_group_name  = var.resource_group_name
  allocation_method    = "Static"
  sku                  = "Standard"
  domain_name_label    = "${var.humber_id}-c-${each.value}"

  tags = var.common_tags
}

resource "azurerm_network_interface" "nic" {
  for_each                      = var.vm_names
  name                          = "${var.humber_id}-${each.key}-nic"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  # enable_accelerated_networking = false
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[each.key].id
  }

  tags = var.common_tags
}
#####
resource "azurerm_managed_disk" "data_disk1" {
  for_each              = var.vm_names
  name                  = "${var.humber_id}-${each.key}-data-disk1"
  location              = var.location
  resource_group_name   = var.resource_group_name
  storage_account_type  = "Standard_LRS"
  create_option         = "Empty"
  disk_size_gb          = 10
}

resource "azurerm_virtual_machine" "vm" {
  for_each                       = var.vm_names
  name                           = "${var.humber_id}-c-${each.key}"
  location                       = var.location
  resource_group_name            = var.resource_group_name
  availability_set_id            = azurerm_availability_set.av_set.id
  network_interface_ids          = [azurerm_network_interface.nic[each.key].id]
  vm_size                        = var.vm_size

  storage_os_disk {
    name              = "${var.humber_id}-${each.key}-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
#####
  storage_data_disk {
    name            = "${var.humber_id}-${each.key}-data-disk1"
    managed_disk_id = azurerm_managed_disk.data_disk1[each.key].id
    lun             = 0
    caching         = "ReadWrite"
    create_option   = "Attach"
    disk_size_gb    = azurerm_managed_disk.data_disk1[each.key].disk_size_gb  # Add this line
  }
  
  # storage_data_disk {
  #   name            = azurerm_managed_disk.data_disk1[each.key].name
  #   managed_disk_id = azurerm_managed_disk.data_disk1[each.key].id
  #   lun             = 0
  #   caching         = "ReadWrite"
  #   create_option   = "Attach"
  # }

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.humber_id}-c-${each.key}"
    admin_username = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = file(var.public_key)
    }
  }

  tags = var.common_tags

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = file(var.private_key)
      host        = azurerm_public_ip.public_ip[each.key].ip_address
    }
    inline = [
      "sudo yum install -y python39",   # Install Python 3.9
      "/usr/bin/hostname"
    ]
  }
}