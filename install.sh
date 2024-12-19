#!/bin/sh
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
CONFIG_FILE="$SCRIPT_DIR/configuration.nix"
PS3="Select host: "
select hostfile in hosts/*.nix; do
  [ -z "$hostfile" ] && echo "Invalid choice." && continue
  sudo ln -sf "$SCRIPT_DIR/$hostfile" "host"
  echo "Set config to $hostfile"
  sudo nixos-rebuild switch --flake ".#$hostfile" --show-trace
  exit 0
done