#!/bin/sh
echo "Options: "
PS3="Selection: "
select hostfile in $(ls ./hosts/*.nix | sed 's#./hosts/##; s#.nix##'); do
  if ! [ -w ./ ]; then
    sudo ln -sfn "./hosts/$hostfile.nix" ./host
  else
    ln -sfn "./hosts/$hostfile.nix" ./host
  fi
  break
done
echo "Host configuration set to: $hostfile"