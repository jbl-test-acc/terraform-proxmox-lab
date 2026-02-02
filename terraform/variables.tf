# --- IDENTIFICATION PROXMOX (Déjà présentes normalement) ---
variable "pm_api_url" {}
variable "pm_api_token_id" {}
variable "pm_api_token_secret" {}

# --- CONFIGURATION DE LA VM ---

variable "vm_name" {
  description = "Le nom de la machine virtuelle dans Proxmox"
  type        = string
  default     = "web-server-01"
}

variable "vm_ip" {
  description = "Adresse IP avec le masque (ex: 192.168.1.10/24)"
  type        = string
}

variable "vm_gateway" {
  description = "La passerelle par défaut (Routeur)"
  type        = string
}

variable "ssh_public_key" {
  description = "Votre clé publique SSH (contenu ou chemin)"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Chemin vers votre clé privée (pour la connexion Terraform)"
  type        = string
  default     = "~/.ssh/id_rsa"
}
