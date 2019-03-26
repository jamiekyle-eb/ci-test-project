#!/bin/bash
set -e

rm -rf ./src/_components
mkdir -p ./src/_components

echo "export const COMPONENTS = []" > ./src/_components.gen.js

for i in {1..1000}; do
  file_path=./src/_components/counter-$i.gen.tsx
  cache_bust=$(uuidgen)
  echo "// Generated file, do not edit manually." > $file_path
  echo "// CACHEBUSTER:$cache_bust" >> $file_path
  cat "./src/templates/counter.tsx" >> $file_path
  echo "COMPONENTS.push(require(\"./_components/counter-$i.gen.tsx\").Counter)" >> ./src/_components.gen.js
done
