#!/bin/bash
set -Eeuxo pipefail

NEEDS_UPDATE=false

# Check node/npm/bolt are on the correct versions
if [[ ! $(node --version) =~ ^v10 ]]; then NEEDS_UPDATE=true; fi
if [[ ! $(npm --version) =~ ^6 ]]; then NEEDS_UPDATE=true; fi
if [[ ! $(yarn --version) =~ ^1.13 ]]; then NEEDS_UPDATE=true; fi

# Check native build tools exist
if [ ! $(command -v gcc) ]; then NEEDS_UPDATE=true; fi
if [ ! $(command -v g++) ]; then NEEDS_UPDATE=true; fi
if [ ! $(command -v make) ]; then NEEDS_UPDATE=true; fi

echo "\$NEEDS_UPDATE=$NEEDS_UPDATE"

if [ $NEEDS_UPDATE == true ]; then
  apt-get update
  apt-get install -y gnupg2
  curl -sL https://deb.nodesource.com/setup_10.x | bash -
  apt-get install -y nodejs gcc g++ make

  npm install --global yarn
fi

echo node: $(node --version)
echo npm: $(npm --version)
echo yarn: $(yarn --version)

echo --- :yarn: Installing Dependencies
yarn install --frozen-lockfile
if [[ $? -ne 0 ]]; then
  echo "^^^ +++"
fi
