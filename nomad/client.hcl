# Increase log verbosity
log_level = "DEBUG"

# Setup data dir
data_dir = "/tmp/nomad/client"

# Don't specify a unique name. Defaults to hostname
# name = "server"

# Enable the client
client {
  enabled = true

  # For demo assume we are talking to server1. For production,
  # this should be like "nomad.service.consul:4647" and a system
  # like Consul used for service discovery.
  servers = ["192.168.1.178:4647"]
}

# Modify our port to avoid a collision with server
ports {
  http = 5656
}

consul {
  address = "192.168.1.178:8500"
  #ssl = true
  #verify_ssl = false
}
