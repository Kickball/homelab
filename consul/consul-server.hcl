# Increase log verbosity
log_level = "DEBUG"

# Setup data dir
data_dir = "/tmp/consul/server"

log_file = "/var/log/"

#Set the datacenter that it is part of
datacenter = "locc"

# Defaults to binding on 0.0.0.0 (all addresses)
bind_addr = "{{ GetPrivateIP }}"

#Set the HTTP/DNS server IP address
client_addr = "{{ GetPrivateIP }}"

#Enable the web ui
ui = true

# Enable the server
server = true

#Enable bootstrapping
#bootstrap = true

# Expect 3 consul servers
bootstrap_expect = 3

#To be setup
connect {
  enabled = true
}

#encrypt = "/3qcep3JKkR3I0jk19KaNrT3YdiM3Op25aW0tBmIs1Y="