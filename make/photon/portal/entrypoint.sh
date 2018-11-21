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
sudo apt-get update
sudo apt-get install -y python 
sudo apt-get install -y python-pip
sudo apt-get install libyaml-dev
 
# Install app dependencies
pip install --upgrade pip
pip install --user PyYAML

python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)' swagger.yaml swagger.json