#!/bin/sh

# secure boot
if [ ! -d /etc/secureboot ]; then
    mkdir -p /etc/secureboot
    chmod 700 /etc/secureboot
fi

nix-env -iA niv -f https://github.com/nmattia/niv/tarball/master \
    --substituters https://niv.cachix.org \
    --trusted-public-keys niv.cachix.org-1:X32PCg2e/zAm3/uD1ScqW2z/K0LtDyNV7RdaxIuLgQM=

sudo sbctl create-keys

# pull config
(rm -rf /etc/nixos && cd /etc/ && sudo git clone https://github.com/schiffy91/nixOS.git nixos)
cd /etc/nixos && sudo niv init && sudo niv add nix-community/lanzaboote -r v0.4.1 -v 0.4.1
sudo git pull && sudo nixos-rebuild switch -I nixos-config=/etc/nixos/configuration.nix --show-trace