VERSION="1.7.3"

echo ${VERSION}

wget https://releases.hashicorp.com/consul/${VERSION}/consul_${VERSION}_linux_armhfv6.zip
unzip -uo consul_${VERSION}_linux_armhfv6.zip
rm consul_${VERSION}_linux_armhfv6.zip
if [ ! -L '/usr/bin/consul' ]; then
  sudo ln -s $PWD/consul /usr/bin/
fi
consul -autocomplete-install
complete -C /usr/local/bin/consul consul
