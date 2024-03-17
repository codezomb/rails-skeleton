#!/bin/sh

trap clean EXIT
set -e

arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/)
terraform_version=1.7.1
sops_version=3.8.1

clean() {
  rm -f *.zip
  rm -rf aws
}

apk update && apk add --virtual build-dependencies build-base
apk add --no-cache postgresql-dev postgresql-client zlib-dev libxml2-dev \
  libxslt-dev readline-dev gcompat tzdata git nodejs curl \
  unzip aws-cli bash

# ----------------------------------------------------------------------------------------------------------------------
# wait-for-it

echo "Downloading wait-for-it..."
curl -sSL https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -o /usr/local/bin/wait-for-it
chmod +x /usr/local/bin/wait-for-it

# ----------------------------------------------------------------------------------------------------------------------
# terraform

curl -sLO https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_${arch}.zip
unzip -o terraform_${terraform_version}_linux_${arch}.zip -d /bin
chmod +x /bin/terraform

# ----------------------------------------------------------------------------------------------------------------------
# sops

curl -sLO https://github.com/mozilla/sops/releases/download/v${sops_version}/sops-v${sops_version}.linux.${arch}
mv sops-v${sops_version}.linux.${arch} /bin/sops && chmod +x /bin/sops
