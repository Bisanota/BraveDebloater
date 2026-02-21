#!/usr/bin/env bash

set -e

echo "Debloating Brave..."

# Detect route
if [ -d "/etc/brave" ]; then
    POLICY_DIR="/etc/brave/policies/managed"
elif [ -d "/etc/opt/brave" ]; then
    POLICY_DIR="/etc/opt/brave/policies/managed"
else
    # If no one exist
    POLICY_DIR="/etc/brave/policies/managed"
fi

# Make directory if not exist
sudo mkdir -p "$POLICY_DIR"

# create policies file
sudo tee "$POLICY_DIR/brave_policies.json" > /dev/null <<EOF
{
  "BraveRewardsDisabled": true,
  "BraveWalletDisabled": true,
  "BraveVPNDisabled": true,
  "BraveAIChatEnabled": false,
  "BraveStatsPingEnabled": false
}
EOF

# Change permissions
sudo chmod 644 "$POLICY_DIR/brave_policies.json"
sudo chown root:root "$POLICY_DIR/brave_policies.json"

echo "Restart Brave Browser and verify on brave://policy"
