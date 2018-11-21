#!/bin/bash
set -e

cd /build_dir
cp -r /portal_src/* .
ls -la

# Update
apt-get update
apt-get install -y python 
apt-get install -y python-pip
apt-get install -y python-dev
apt-get install -y libyaml-dev
 
# Install app dependencies
pip install --upgrade pip
pip install --user PyYAML

python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)' swagger.yaml swagger.json

cat ./package.json
npm install

## Build harbor-portal and link it
npm run build_lib
npm run link_lib

## Build production
npm run release



