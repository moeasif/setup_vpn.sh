#!/bin/bash

# WireGuard VPN Auto-Setup Script
set -e

WG_INTERFACE="wg0"
WG_PORT="51820"
WG_IP="10.0.0.1/24"
WG_CONFIG="/etc/wireguard/$WG_INTERFACE.conf"
PRIVATE_KEY_FILE="/etc/wireguard/privatekey"
PUBLIC_KEY_FILE="/etc/wireguard/publickey"

echo "[*] Installing WireGuard..."
apt update && apt install -y wireguard

echo "[*] Generating server keys..."
umask 077
wg genkey | tee "$PRIVATE_KEY_FILE" | wg pubkey > "$PUBLIC_KEY_FILE"
SERVER_PRIVATE_KEY=$(cat "$PRIVATE_KEY_FILE")

echo "[*] Configuring WireGuard interface..."
cat > "$WG_CONFIG" <<EOF
[Interface]
PrivateKey = $SERVER_PRIVATE_KEY
Address = $WG_IP
ListenPort = $WG_PORT
PostUp = iptables -A FORWARD -i $WG_INTERFACE -j ACCEPT
PostDown = iptables -D FORWARD -i $WG_INTERFACE -j ACCEPT
EOF

echo "[*] Enabling IP forwarding..."
sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

echo "[*] Starting WireGuard service..."
systemctl enable wg-quick@$WG_INTERFACE
systemctl start wg-quick@$WG_INTERFACE

echo "[+] WireGuard VPN setup complete!"
echo "Server public key: $(cat $PUBLIC_KEY_FILE)"

