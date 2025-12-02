#!/usr/bin/env bash
set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "[bootstrap-dev] Using repo root: $REPO_ROOT"

cd "$REPO_ROOT"

echo
echo "[bootstrap-dev] Step 1: Terraform apply with dynamic IP"
./scripts/tf-dev-apply.sh

echo
echo "[bootstrap-dev] Step 2: Refresh Ansible inventory"
./scripts/gen-dev-inventory.sh

echo
echo "[bootstrap-dev] Fetching current Jenkins public IP from Terraform outputs..."
JENKINS_IP=$(terraform -chdir=terraform output -raw jenkins_public_ip)

echo
echo "[bootstrap-dev] Environment is ready."
echo
echo "URLs:"
echo "  Jenkins:     http://$JENKINS_IP:8080"
echo "  Prometheus:  http://$JENKINS_IP:9090"
echo "  Grafana:     http://$JENKINS_IP:3000"
echo "  Demo app:    http://$JENKINS_IP:5000"
echo
echo "Next step (run in WSL/Ubuntu):"
echo "  cd \"$REPO_ROOT\""
echo "  ansible-playbook -i ansible/inventory/dev ansible/site.yml"
echo

