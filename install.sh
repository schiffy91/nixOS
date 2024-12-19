#!/bin/sh
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
PS3="Select host: "
select host in MBP-M1-VM FRACTAL-NORTH; do
    [ -z "$host" ] && echo "Invalid choice." && continue
    echo "Building configuration for $host"
    sudo nixos-rebuild switch --flake ".#$host" --show-trace
    exit 0
done