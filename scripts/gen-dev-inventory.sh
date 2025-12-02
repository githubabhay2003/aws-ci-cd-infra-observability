#!/usr/bin/env bash
set -e

# Run terraform output from the terraform directory
JENKINS_IP=$(terraform -chdir=terraform output -raw jenkins_public_ip)

echo "[gen-dev-inventory] Using Jenkins public IP: ${JENKINS_IP}"

cat > ansible/inventory/dev <<EOF
[jenkins_host]
jenkins-dev ansible_host=${JENKINS_IP} ansible_user=ubuntu ansible_ssh_private_key_file=/home/abhay/.ssh/jenkins-aws
EOF

echo "[gen-dev-inventory] ansible/inventory/dev updated."

