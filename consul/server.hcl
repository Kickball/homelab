# Increase log verbosity
log_level = "DEBUG"

# Setup data dir
data_dir = "/tmp/consul/server"

#Set the datacenter that it is part of
datacenter = "dc1"

#Set the IP address
bind_addr = "192.168.1.178"

#Set the HTTP/DNS server IP address
client_addr = "192.168.1.178"

#Enable the web ui
ui = true

#Enable bootstrapping
bootstrap = true

# Enable the server
server = true

# Self-elect, should be 3 or 5 for production
bootstrap_expect = 1

connect {
  enabled = true
}

#encrypt = "/3qcep3JKkR3I0jk19KaNrT3YdiM3Op25aW0tBmIs1Y="
