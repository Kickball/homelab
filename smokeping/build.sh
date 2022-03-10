podman build -t smokeping . --build-arg SMOKEPING_VERSION=$1
podman tag smokeping:latest 192.168.20.132:5000/smokeping
