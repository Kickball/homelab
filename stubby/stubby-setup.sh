#!/bin/bash

if [[ $EUID > 0 ]]; then
  echo "Please run as root"
  exit 1
fi

check_binaries_installed() {
  # Potential edge case exists where package is installed but not on the path of the root. This check would error out, but the script would actually work as we reference the full path to the binary.
  binaries=("cp" "mkdir")
  for i in "${binaries[@]}"
  do
    /bin/which "$i" &> /dev/null
    if [ $? -ne 0 ]; then
      echo "Unable to locate binary: $i"
      exit 1
    fi
  done
}

add_stubby_config () {
  if [ ! -d /etc/stubby ]; then
    mkdir /etc/stubby
  fi
  if [ ! -f /etc/stubby/stubby.yml ]; then
    cp stubby.yml /etc/stubby/stubby.yml
  else
    # Todo - Add SHA256SUM check
    cp --force stubby.yml /etc/stubby/stubby.yml
  fi
}

# Check that the script's dependancies have been installed
check_binaries_installed

# Copy configuration file(s)
add_stubby_config