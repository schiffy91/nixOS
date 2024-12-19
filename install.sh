#!/bin/sh
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
CONFIG_FILE="$SCRIPT_DIR/configuration.nix"
PS3="Select host: "
select hostfile in hosts/*.nix; do
  [ -z "$hostfile" ] && echo "Invalid choice." && continue
  ln -sf "$SCRIPT_DIR/$hostfile" "$CONFIG_FILE"
  echo "Set config to $hostfile"
  nixos-rebuild switch -I "nixos-config=$CONFIG_FILE" --show-trace
  exit 0
done