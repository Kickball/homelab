wget https://releases.hashicorp.com/vault/1.4.1/vault_1.4.1_linux_arm.zip
unzip -u vault_1.4.1_linux_arm.zip
rm vault_1.4.1_linux_arm.zip
if [ ! -L '/usr/bin/vault' ]; then
  sudo ln -s $PWD/vault /usr/bin/
fi
vault -autocomplete-install
exec $SHELL
