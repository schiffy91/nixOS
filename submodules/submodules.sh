#!/bin/sh
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
cd $SCRIPT_DIR

git submodule add --force https://github.com/nix-community/lanzaboote.git lanzaboote
cd lanzaboote && git checkout tags/v0.4.1 -b v0.4.1 && cd ..

git submodule add --force https://github.com/nix-community/disko.git disko
cd disko && git checkout tags/v1.10.0 -b v1.10.0 && cd ..