VERSION=0.11.2

#Detect host type (e.g. sm [server master] = nomad server, ss [server slave] = nomad server & nomad client, sw [server worker] = nomad client)
HOST_TYPE= /bin/echo $HOSTNAME | grep -oP "[A-Za-z]{2}(?=[0-9])+"

# Check if nomad is already setup as a service
if [${HOST_TYPE} = "sm"]; then
  if [service --status-all | grep -Fq 'nomad']; then
    # Stop nomad services, if they exists.
    if [service --status-all | grep -Fq 'nomad-client']; then
      sudo service nomad-client stop
    fi
    if [service --status-all | grep -Fq 'nomad-server]'; then
      sudo service nomad-server stop
    fi
  fi
fi

# Download and "install" the requested version.
wget https://releases.hashicorp.com/nomad/${VERSION}/nomad_${VERSION}_linux_arm.zip
unzip -uo nomad_{VERSION}_linux_arm.zip
rm nomad_{VERSION}_linux_arm.zip

# Create symlink to a directory on the PATH if doesn't exist.
if [ ! -L '/usr/bin/nomad' ]; then
  sudo ln -s $PWD/nomad /usr/bin/
fi
