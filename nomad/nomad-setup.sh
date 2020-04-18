wget https://releases.hashicorp.com/nomad/0.11.0/nomad_0.11.0_linux_arm.zip
unzip -u nomad_0.11.0_linux_arm.zip
rm nomad_0.11.0_linux_arm.zip
if [ ! -L '/usr/bin/nomad' ]; then
  sudo ln -s $PWD/nomad /usr/bin/
fi
