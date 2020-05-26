#!/bin/bash

if [[ $EUID > 0 ]]; then
  echo "Please run as root"
  exit 1
fi

VERSION="1.7.3"

#Detect host type (e.g. sm [server master] & ss [server slave] = consul server & consul client, sw [server worker] = consul client)
HOST_TYPE=$(echo $HOSTNAME | grep -oP "[A-Za-z]{2}(?=[0-9])+")

download_and_install_consul () {
  # Download and "install" the requested version.
  wget https://releases.hashicorp.com/consul/${VERSION}/consul_${VERSION}_linux_armhfv6.zip
  unzip -uo consul_${VERSION}_linux_armhfv6.zip
  rm consul_${VERSION}_linux_armhfv6.zip
  if [ ! -L '/usr/bin/consul' ]; then
   sudo ln -s $PWD/consul /usr/bin/
  fi
  consul -autocomplete-install
  complete -C /usr/bin/consul consul
}

add_consul_config_file () {
  if [ ! -d /etc/consul-$1.d ]; then
    mkdir /etc/consul-$1.d
  fi
  if [ ! -f /etc/consul-$1.d/consul-$1.hcl ]; then
    cp consul-$1.hcl /etc/consul-$1.d/consul-$1.hcl
  fi
}

add_consul_systemd_entry () {
  if [ ! -f /etc/systemd/system/consul-$1.service ]; then
    cp consul-$1.service /etc/systemd/system/consul-$1.service
  fi
}

# Check if consul is already setup as a service
if [ "${HOST_TYPE}" = "sm" ] || [ "${HOST_TYPE}" = "ss" ]; then
  echo "ss or sm detected"
  # Stop consul services, if they exists.
  if [ -f /etc/systemd/system/consul-server.service ]; then
    systemctl stop consul-server
  fi
  if [ -f /etc/systemd/system/consul-client.service ]; then
    systemctl stop consul-client
  fi
  #Download and 'install' the consul binary
  download_and_install_consul
  
  # Setup consul client
  add_consul_config_file client
  add_consul_systemd_entry client

  #Setup consul server
  add_consul_config_file server
  add_consul_systemd_entry server

  # Enable and Start consul Services
  systemctl enable consul-client
  systemctl start consul-client
  systemctl enable consul-server
  systemctl start consul-server
elif [ "${HOST_TYPE}" = "sw" ]; then
  echo "sw detected"
  # Stop consul services, if they exists.
  if [ -f /etc/systemd/system/consul-client.service ]; then
    systemctl stop consul-client
  fi
  #Download and 'install' the consul binary
  download_and_install_consul

  # Setup consul client
  add_consul_config_file client
  add_consul_systemd_entry client

  # Enable and Start consul Services
  systemctl enable consul-client
  systemctl start consul-client
fi