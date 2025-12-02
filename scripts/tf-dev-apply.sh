#!/usr/bin/env bash
set -e

# Go to terraform directory relative to script location
cd "$(dirname "$0")/../terraform"

echo "[tf-dev-apply] Detecting your public IP..."
MY_IP=$(curl -s https://checkip.amazonaws.com)

echo "[tf-dev-apply] Using my_ip=${MY_IP}"

terraform apply \
  -var-file="environments/dev.tfvars" \
  -var="my_ip=${MY_IP}"

