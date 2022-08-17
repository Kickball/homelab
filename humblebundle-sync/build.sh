IP=$(ip addr show $(ip route | awk '/default/ { print $5 }') | grep "inet" | head -n 1 | awk '/inet/ {print $2}' | cut -d'/' -f1)
PORT=5000
podman build -t humblebundle-sync .
podman tag humblebundle-sync:latest $IP:$PORT/humblebundle-sync
