#!/bin/bash
set -euxo pipefail

# Update + install deps
apt-get update -y
apt-get install -y curl jq unzip

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

# Install Tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# Fetch Tailscale auth key
TSKEY=$(aws secretsmanager get-secret-value \
  --secret-id ${tailscale_secret_arn} \
  --query SecretString \
  --output text \
  --region ${region})

# Enable IP forwarding
sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/99-tailscale.conf

# Start Tailscale
tailscale up \
  --authkey="$TSKEY" \
  --advertise-routes=${private_cidr} \
  --hostname=${hostname} \
  --accept-routes \
  --ssh
