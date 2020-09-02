server=false

datacenter = "locc"

data_dir = "/tmp/consul/client"

log_file = "/var/log/"

#encrypt = "/3qcep3JKkR3I0jk19KaNrT3YdiM3Op25aW0tBmIs1Y="

#Set the IP address
bind_addr = "{{ GetPrivateIP }}"

client_addr = "{{ GetPrivateIP }}"

#The list of servers consul should attempt to become a client of
retry_join = ["{{ GetPrivateIP }}"]