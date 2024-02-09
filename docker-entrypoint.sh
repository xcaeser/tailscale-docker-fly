#!/bin/bash
set -e

echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.conf
sysctl -p /etc/sysctl.conf
ethtool -K eth0 gro on
# Start the Tailscale daemon in the background
tailscaled &

# Wait a bit for tailscaled to start up
sleep 5

# Authenticate and set up this node as an exit node
# Note: You might need to handle authentication differently,
# such as using an auth key for automated setups.
tailscale up --authkey TO BE REPLACED --advertise-exit-node

# Keep the script running to prevent the container from exiting
# This can be replaced with other long-running commands as needed
exec "$@"
