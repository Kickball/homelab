#!/bin/bash

if [[ $EUID > 0 ]]; then
  echo "Please run as root"
  exit 1
fi

VERSION="1.2.5"

check_binaries_installed() {
  # Potential edge case exists where package is installed but not on the path of the root. This check would error out, but the script would actually work as we reference the full path to the binary.
  binaries=("cat" "wget" "ln" "cp" "unzip")
  for i in "${binaries[@]}"
  do
    /bin/which "$i" &> /dev/null
    if [ $? -ne 0 ]; then
      echo "Unable to locate binary: $i"
      exit 1
    fi
  done
}

download_and_install_nomad () {
  # Download and "install" the requested version.
  /usr/bin/wget https://releases.hashicorp.com/nomad/${VERSION}/nomad_${VERSION}_linux_arm64.zip
  /usr/bin/unzip -uo nomad_${VERSION}_linux_arm64.zip
  /bin/rm nomad_${VERSION}_linux_arm64.zip

  # Create symlink to a directory on the PATH if doesn't exist.
  if [ ! -L '/usr/bin/nomad' ]; then
    ln -s $PWD/nomad /usr/bin/
  fi
}

add_nomad_config_file () {
  if [ ! -d /etc/nomad-$1.d ]; then
    mkdir /etc/nomad-$1.d
  fi
  if [ ! -f /etc/nomad-$1.d/nomad-$1.hcl ]; then
    cp nomad-$1.hcl /etc/nomad-$1.d/nomad-$1.hcl
  else
    # Todo - Add SHA256SUM check
    cp --force nomad-$1.hcl /etc/nomad-$1.d/nomad-$1.hcl
  fi
}

add_nomad_systemd_entry () {
  if [ ! -f /etc/systemd/system/nomad-$1.service ]; then
    cp nomad-$1.service /etc/systemd/system/nomad-$1.service
  else
    # Todo - Add SHA256SUM check
    cp --force nomad-$1.service /etc/systemd/system/nomad-$1.service
  fi
}

# Check that hte script's dependancies have been installed
check_binaries_installed

# Detect host type (e.g. sm [server master] = nomad server, ss [server slave] = nomad server & nomad client, sw [server worker] = nomad client)
HOST_TYPE=$(/bin/cat /etc/hostname | grep -oP "[A-Za-z]{2}(?=[0-9])+")

# Check if nomad is already setup as a service
if [ "${HOST_TYPE}" = "sm" ]; then
  echo "sm detected"
  # Stop nomad services, if they exists.
  if [ -f /etc/systemd/system/nomad-server.service ]; then
    systemctl stop nomad-server
  fi
  # Download and 'install' the nomad binary
  download_and_install_nomad

  #Setup Nomad server
  add_nomad_config_file server
  add_nomad_systemd_entry server

  # Enable and Start Nomad Services
  systemctl enable nomad-server
  systemctl start nomad-server
elif [ "${HOST_TYPE}" = "ss" ]; then
  echo "ss detected"
  # Stop nomad services, if they exists.
  if [ -f /etc/systemd/system/nomad-server.service ]; then
    systemctl stop nomad-server
  fi
  if [ -f /etc/systemd/system/nomad-client.service ]; then
    systemctl stop nomad-client
  fi
  #Download and 'install' the nomad binary
  download_and_install_nomad
  
  # Setup Nomad client
  add_nomad_config_file client
  add_nomad_systemd_entry client

  #Setup Nomad server
  add_nomad_config_file server
  add_nomad_systemd_entry server

  # Enable and Start Nomad Services
  systemctl enable nomad-client
  systemctl start nomad-client
  systemctl enable nomad-server
  systemctl start nomad-server
elif [ "${HOST_TYPE}" = "sw" ]; then
  echo "sw detected"
  # Stop nomad services, if they exists.
  if [ -f /etc/systemd/system/nomad-client.service ]; then
    systemctl stop nomad-client
  fi
  #Download and 'install' the nomad binary
  download_and_install_nomad

  # Setup Nomad client
  add_nomad_config_file client
  add_nomad_systemd_entry client

  # Enable and Start Nomad Services
  systemctl enable nomad-client
  systemctl start nomad-client
fi
