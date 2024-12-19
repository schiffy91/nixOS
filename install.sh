#!/bin/sh
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
PS3="Select host: "
select host in $(ls "$SCRIPT_DIR/hosts" | sed 's/\.nix$//'); do
    [ -z "$host" ] && echo "Invalid choice." && continue
    echo "Building configuration for $host"
    sudo nixos-rebuild switch --flake ".#$host"
    exit 0
done