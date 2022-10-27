resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_B1s"
  admin_username      = "Shakirat"
  network_interface_ids = [azurerm_network_interface.test.id,]
  admin_ssh_key {
    username   = "Shakirat"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIRFjX6Nh13WrCYl0r0zBW9RNYHkUAUcuTFIU7x2AxAVS64mBqwZ4JGETiYEcNiRP4SdKv54sS2CfdC7PtfzjbTGrW27ovsw48irHbwx90vX2pfS1QmJTl8/9IOOvGoJgLAaHuZ25LJF0RDAr55jzZkozbinLfsDWIuGgzaY34k9PBnHFrYlsolKdgYc2t4Dn0FgDNfegrfIlD8v98D+NXykdnyy15hiXO8LBIkRwglwRS5xwkK9/OqpFbW3/GPJTZQAJdtJ7pnvq6CSpJBFvXWUii9i4thIjx4HxdlFE3rholHfLrO75Ej0rywxtG5Zbkdj8QOrgJ/T2geJWf97wZXQlzmZM2zoR6xR94wk/lospODi6sOyuGPWqdxn7YAtfxBU87i15A5rzjq+fN6ZZ2K1bS+xH7qKQahc3F61EE7YcLZsW78xSVLeov1Ard1x0w+ZqDA6Lwq32FjWaKQIIBrwPSxIPT3W7Dr62AECk+H8Ity8IS/Ms6SR6GJZuf+T8= dell@DESKTOP-AITGIQC"
    #public_key = file(var.vm_public_key) 
     
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
