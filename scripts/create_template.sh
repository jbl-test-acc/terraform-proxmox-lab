#!/bin/bash


# 1. Télécharger l'image Cloud de Ubuntu
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img

# 2. Créer une VM vide (ID 9000)
qm create 9000 --name "ubuntu-cloud-template" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0

# 3. Importer le disque téléchargé dans le stockage local-lvm
qm importdisk 9000 jammy-server-cloudimg-amd64.img local-lvm

# 4. Attacher le disque à la VM (scsi0)
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0

# 5. Ajouter le lecteur Cloud-Init (Indispensable pour Terraform)
qm set 9000 --ide2 local-lvm:cloudinit

# 6. Définir l'ordre de boot et la configuration série (pour la console)
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --serial0 socket --vga serial0

# 7. Convertir en Template (Le transformer en "Moule")
qm template 9000
