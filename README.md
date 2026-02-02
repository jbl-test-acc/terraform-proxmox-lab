Proxmox HomeLab Infrastructure

Ce projet contient le code nécessaire pour déployer automatiquement des environnements de test sur mon serveur Proxmox.

Technologies utilisées

Proxmox VE 9 (Virtualisation)

Terraform (Provisioning des VMs)

Cloud-Init (Configuration au démarrage : SSH, Utilisateurs)

Bash (Automatisation de la création de templates)

Fonctionnement

Le script create_template.sh télécharge l'image Ubuntu Cloud et prépare le template.
Terraform clone ce template et configure l'IP statique et les clés SSH.
