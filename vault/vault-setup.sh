VERSION=1.4.2

wget https://releases.hashicorp.com/vault/${VERSION}/vault_${VERSION}_linux_arm.zip
unzip -uo vault_${VERSION}_linux_arm.zip
rm vault_${VERSION}_linux_arm.zip
if [ ! -L '/usr/bin/vault' ]; then
  sudo ln -s $PWD/vault /usr/bin/
fi
vault -autocomplete-install
exec $SHELL
