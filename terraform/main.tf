resource "proxmox_vm_qemu" "mon-serveur-web" {
  # On utilise la variable ici
  name        = var.vm_name
  target_node = "pve"
  clone       = "ubuntu-cloud-template"
  full_clone  = true
  os_type     = "cloud-init"

  cpu {
    cores   = 2
    sockets = 1
  }

  memory = 2048
  scsihw = "virtio-scsi-pci"
  boot   = "order=scsi0"
  agent  = 1

  disk {
    slot    = "scsi0"
    storage = "local-lvm"
    type    = "disk"
    size    = "15G"
    discard = true
  }

  disk {
    slot    = "ide2"
    storage = "local-lvm"
    type    = "cloudinit"
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  # --- C'est ici que la magie opère (Interpolation) ---
  # On construit la chaîne "ip=...,gw=..." dynamiquement
  ipconfig0 = "ip=${var.vm_ip},gw=${var.vm_gateway}"

  # DNS
  nameserver = "1.1.1.1"

  ciuser  = "devops"
  sshkeys = var.ssh_public_key

  vga {
    type = "std"
  }

  connection {
    type = "ssh"
    user = "devops"
    # On utilise le chemin variable
    private_key = file(var.ssh_private_key_path)
    # On reprend l'IP définie dans la variable, mais sans le masque (/28)
    # Astuce : split permet de couper "192.168.1.0/24" pour garder juste l'IP
    host    = element(split("/", var.vm_ip), 0)
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo '⏳ Attente boot...'",
      "sleep 10",
      "while fuser /var/lib/dpkg/lock >/dev/null 2>&1; do sleep 1; done",
      "sudo apt-get update",
      "sudo apt-get install -y qemu-guest-agent nginx",
      "sudo systemctl start qemu-guest-agent",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "echo '✅ Web Server Ready!'"
    ]
  }
}
