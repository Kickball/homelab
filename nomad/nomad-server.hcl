# Increase log verbosity
log_level = "DEBUG"

# Setup data dir
data_dir = "/tmp/nomad/server"

#Set the datacenter that it is part of
datacenter = "locc"

# Don't specify a unique name. Defaults to hostname
# name = "server"

# Enable the server
server {
  enabled = true

  # Expect 3 nomad servers
  bootstrap_expect = 3
}

consul {
  address = "192.168.1.178:8500"
  #ssl = true
  #verify_ssl = false
}
