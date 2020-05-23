VERSION=0.11.2

#Detect host type (e.g. sm [server master] = nomad server, ss [server slave] = nomad server & nomad client, sw [server worker] = nomad client)
HOST_TYPE=$(echo $HOSTNAME | grep -oP "[A-Za-z]{2}(?=[0-9])+")

function download_and_install {
  # Download and "install" the requested version.
  /usr/bin/wget https://releases.hashicorp.com/nomad/${VERSION}/nomad_${VERSION}_linux_arm.zip
  /usr/bin/unzip -uo nomad_{VERSION}_linux_arm.zip
  /bin/rm nomad_{VERSION}_linux_arm.zip

  # Create symlink to a directory on the PATH if doesn't exist.
  if [ ! -L '/usr/bin/nomad' ]; then
    sudo ln -s $PWD/nomad /usr/bin/
  fi
}

# Check if nomad is already setup as a service
if [ "${HOST_TYPE}" = "sm" ]; then
  echo "sm detected"
  # Stop nomad services, if they exists.
  if [ systemctl status 2>/dev/null | grep -Fq 'nomad-server' ]; then
    sudo systemctl stop nomad-server
  fi
elif [ "${HOST_TYPE}" = "ss" ]; then
  echo "ss detected"
  # Stop nomad services, if they exists.
  if [ systemctl status 2>/dev/null | grep -Fq 'nomad-server ]'; then
    sudo systemctl stop nomad-server
  fi
  if [ systemctl status 2>/dev/null | grep -Fq 'nomad-client' ]; then
    sudo systemctl stop nomad-server
  fi
elif [ "${HOST_TYPE}" = "sw" ]; then
  echo "sw detected"
  # Stop nomad services, if they exists.
  if [ systemctl status 2>/dev/null | grep -Fq 'nomad-client' ]; then
    sudo systemctl stop nomad-server
  fi
fi
