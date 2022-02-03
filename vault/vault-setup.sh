VERSION=1.9.3

wget https://releases.hashicorp.com/vault/${VERSION}/vault_${VERSION}_linux_arm64.zip
unzip -uo vault_${VERSION}_linux_arm64.zip
rm vault_${VERSION}_linux_arm64.zip
if [ ! -L '/usr/bin/vault' ]; then
  sudo ln -s $PWD/vault /usr/bin/
fi
vault -autocomplete-install
exec $SHELL
