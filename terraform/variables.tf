variable "pm_api_url" {
  type        = string
  description = "L'URL de l'API Proxmox"
}

variable "pm_api_token_id" {
  type        = string
  description = "L'ID du token utilisateur"
}

variable "pm_api_token_secret" {
  type        = string
  description = "Le secret du token (Ne pas partager !)"
  sensitive   = true  # Empêche Terraform d'afficher ce secret dans les logs
}

variable "ssh_public_key" {
  type        = string
  description = "Ma clé publique SSH pour se connecter aux VMs"
}
