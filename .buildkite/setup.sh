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
  echo "--- Installing native dependencies"
  apt-get update
  apt-get install -y gnupg2
  curl -sL https://deb.nodesource.com/setup_10.x | bash -
  apt-get install -y nodejs gcc g++ make

  npm install --global yarn
fi

echo node: $(node --version)
echo npm: $(npm --version)
echo yarn: $(yarn --version)

YARN_CACHE_PATH="/caches/yarn/$BUILDKITE_ORGANIZATION_SLUG/$BUILDKITE_PIPELINE_SLUG"

if ! cmp --silent node_modules/.yarn-integrity $YARN_CACHE_PATH/node_modules/.yarn-integrity; then
  echo "--- :yarn: Restoring from cache"
  rm -rf node_modules
  mkdir -p $YARN_CACHE_PATH/node_modules
  cp -r $YARN_CACHE_PATH/node_modules node_modules
fi

echo "--- :yarn: Installing dependencies"
yarn install --frozen-lockfile
if [[ $? -ne 0 ]]; then
  echo "^^^ +++"
else
  if ! cmp --silent node_modules/.yarn-integrity $YARN_CACHE_PATH/node_modules/.yarn-integrity; then
    echo "--- :yarn: Saving to cache"
    cp -r node_modules $YARN_CACHE_PATH
  fi
fi

echo "+++ :buildkite: Running job command"
