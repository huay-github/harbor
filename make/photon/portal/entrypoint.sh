#!/bin/bash
set -e

cd /build_dir
cp -r /portal_src/* .
ls -la

cat ./package.json
npm install

## Build harbor-portal and link it
npm run build_lib
npm run link_lib

## Build production
npm run release

# Update
apt-get update
apt-get install -y python 
apt-get install -y python-pip
 
# Install app dependencies
pip install --upgrade pip
pip install pyyaml

python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)' swagger.yaml swagger.json