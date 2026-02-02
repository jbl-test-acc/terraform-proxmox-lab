# Fichier : outputs.tf

output "ip_address" {
  value = var.vm_ip
  description = "L'adresse IP du serveur web"
}

output "url" {
  value = "http://${element(split("/", var.vm_ip), 0)}"
  description = "Lien direct vers le site web"
}
