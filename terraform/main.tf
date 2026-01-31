terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret # La variable sécurisée
  pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "mon-serveur-web" {
  name        = "web-server-01"
  target_node = "pve" # Le nom de votre nœud Proxmox
  ciuser  = "adminuser"
  sshkeys = var.ssh_public_key # Injection de la clé
  clone       = "ubuntu-template" # Le nom de votre template (voir note ci-dessous)
  
  cores       = 2
  memory      = 2048
  
  # Configuration Cloud-Init (Magique pour configurer l'IP et le user SSH)
  ciuser      = "adminuser"
  sshkeys     = <<EOF
  ssh-rsa AAAAB3Nza... votre-clé-publique
  EOF
}


