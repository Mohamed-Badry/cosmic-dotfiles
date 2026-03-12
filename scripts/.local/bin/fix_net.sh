#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., sudo ./fix_net.sh)"
  exit 1
fi

echo "Starting network optimization for unstable 4G tethering..."

# -----------------------------------------------------------------------------
# 1. Spoof TTL (Time To Live)
# -----------------------------------------------------------------------------
# Why: Mobile carriers often detect tethering by inspecting the TTL of packets.
# A phone's traffic usually has a TTL of 64. When you tether, your laptop sends 
# packets with TTL 64, which decrement to 63 when passing through the phone. 
# The carrier sees 63 and knows it's tethered traffic, potentially throttling it.
# By setting the default TTL to 65, it decrements to 64 at the phone, making 
# your traffic look like it originated directly from the mobile device.
echo "[-] Setting TCP TTL to 65 to mask tethering..."
sysctl -w net.ipv4.ip_default_ttl=65 > /dev/null

# -----------------------------------------------------------------------------
# 2. Enable TCP BBR Congestion Control
# -----------------------------------------------------------------------------
# Why: Standard TCP congestion algorithms (like Cubic) interpret packet loss as 
# network congestion and drastically reduce speed. 4G/LTE networks are "noisy" 
# and often have random packet loss that isn't due to congestion.
# BBR (Bottleneck Bandwidth and Round-trip propagation time) focuses on actual 
# bandwidth and latency, ignoring random packet loss. This prevents the connection 
# from stalling or dropping to zero speed during noise bursts.
echo "[-] Enabling TCP BBR congestion control..."
modprobe tcp_bbr
sysctl -w net.core.default_qdisc=fq > /dev/null
sysctl -w net.ipv4.tcp_congestion_control=bbr > /dev/null

# -----------------------------------------------------------------------------
# 3. Fix MTU (Maximum Transmission Unit)
# -----------------------------------------------------------------------------
# Why: Standard Ethernet uses an MTU of 1500 bytes. Cellular networks wrap your 
# traffic in tunnels (GTP/IPsec), adding headers that take up space. 
# If your packet is 1500 bytes + carrier headers, it exceeds the physical limit.
# This causes fragmentation (slow) or "Black Hole" drops (stalls) where large 
# packets simply vanish. 
# Setting MTU to 1350 is a safe bet to fit inside any carrier tunnel.
echo "[-] Detecting active network interface..."

# Detect the interface used for the default route (internet connection)
INTERFACE=$(ip route show default | awk '/default/ {print $5}' | head -n 1)

if [[ -z "$INTERFACE" ]]; then
    echo "Error: Could not detect the active network interface automatically."
    echo "Please manually run: ip link set dev <YOUR_INTERFACE_NAME> mtu 1350"
else
    echo "[-] Found active interface: $INTERFACE"
    echo "[-] Setting MTU to 1350..."
    ip link set dev "$INTERFACE" mtu 1350
fi

# -----------------------------------------------------------------------------
# 4. Verification
# -----------------------------------------------------------------------------
echo ""
echo "=== Verification ==="
echo "1. TTL Status: $(sysctl -n net.ipv4.ip_default_ttl) (Target: 65)"
echo "2. TCP Algorithm: $(sysctl -n net.ipv4.tcp_congestion_control) (Target: bbr)"

if [[ -n "$INTERFACE" ]]; then
    CURRENT_MTU=$(ip link show dev "$INTERFACE" | grep -o 'mtu [0-9]*' | awk '{print $2}')
    echo "3. MTU for $INTERFACE: $CURRENT_MTU (Target: 1350)"
fi

echo ""
echo "Network optimizations applied."
