wget https://releases.hashicorp.com/consul/1.7.2/consul_1.7.2_linux_armhfv6.zip
unzip -uo consul_1.7.2_linux_armhfv6.zip
rm consul_1.7.2_linux_armhfv6.zip
if [ ! -L '/usr/bin/consul' ]; then
  sudo ln -s $PWD/consul /usr/bin/
fi
consul -autocomplete-install
complete -C /usr/local/bin/consul consul
