VERSION=0.11.2

wget https://releases.hashicorp.com/nomad/${VERSION}/nomad_${VERSION}_linux_arm.zip
unzip -uo nomad_{VERSION}_linux_arm.zip
rm nomad_{VERSION}_linux_arm.zip
if [ ! -L '/usr/bin/nomad' ]; then
  sudo ln -s $PWD/nomad /usr/bin/
fi
