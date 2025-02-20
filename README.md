Features
✅ Installs WireGuard
✅ Generates server keys automatically
✅ Configures the WireGuard interface (wg0)
✅ Enables packet forwarding for VPN traffic
✅ Starts the VPN service

Installation Instructions
  Save the script as setup_vpn.sh.  
  Run the script with:
  ~ chmod +x setup_vpn.sh && sudo ./setup_vpn.sh


How It Works
  1 Installs WireGuard if not already installed.
  2 Generates server keys and stores them securely.
  3 Creates the WireGuard configuration file (wg0.conf).
  4 Enables IP forwarding for VPN traffic.
  5 Starts and enables the WireGuard service on boot.


To add clients, generate a key pair and add them to the server config.
Want a client setup script? Let me know! 
