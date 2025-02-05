resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size               = var.vm_size
  admin_username     = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic.id]

  admin_password = var.admin_password
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  custom_data = base64encode(<<EOF
#!/bin/bash
# Update system
apt-get update -y
apt-get upgrade -y

# Install Docker
apt-get install -y docker.io

# Enable and start Docker service
systemctl enable docker
systemctl start docker

# Add current user to Docker group (optional)
usermod -aG docker ${var.admin_username}

# Install Portainer
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer \
  --restart=always -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data portainer/portainer-ce

EOF
  )
}
