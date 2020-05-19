# Increase log verbosity
log_level = "DEBUG"

# Setup data dir
data_dir = "/tmp/nomad/server"

# Don't specify a unique name. Defaults to hostname
# name = "server"

# Enable the server
server {
  enabled = true

  # Self-elect, should be 3 or 5 for production
  bootstrap_expect = 1
}

consul {
  address = "192.168.1.178:8500"
  #ssl = true
  #verify_ssl = false
}
