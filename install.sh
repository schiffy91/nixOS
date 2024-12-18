#!/bin/sh

# secure boot
if [ ! -d /etc/secureboot ]; then
    mkdir -p /etc/secureboot
    chmod 700 /etc/secureboot
fi
sudo sbctl create-keys

# pull config
(rm -rf /etc/nixos && cd /etc/ && sudo git clone https://github.com/schiffy91/nixOS.git nixos)
cd /etc/nixos && sudo niv init && sudo niv add nix-community/lanzaboote -r v0.4.1 -v 0.4.1
sudo git pull && sudo nixos-rebuild switch