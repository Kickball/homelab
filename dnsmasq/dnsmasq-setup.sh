#!/bin/bash

if [[ $EUID > 0 ]]; then
  echo "Please run as root"
  exit 1
fi

check_binaries_installed() {
  # Potential edge case exists where package is installed but not on the path of the root. This check would error out, but the script would actually work as we reference the full path to the binary.
  binaries=("cp" "mkdir" "find")
  for i in "${binaries[@]}"
  do
    /bin/which "$i" &> /dev/null
    if [ $? -ne 0 ]; then
      echo "Unable to locate binary: $i"
      exit 1
    fi
  done
}

add_dnsmasq_config () {
  if [ ! -d /etc/dnsmasq.d ]; then
    mkdir /etc/dnsmasq.d
  fi

  for f in ./*.conf; do
    if [ ! -f /etc/dnsmasq.d/"$f" ]; then
        cp "$f" /etc/dnsmasq.d/
    else
        # Todo - Add SHA256SUM check
        cp --force "$f" /etc/dnsmasq.d/
    fi
  done
}

# Check that the script's dependancies have been installed
check_binaries_installed

# Copy configuration file(s)
add_dnsmasq_config