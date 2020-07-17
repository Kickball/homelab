server=false

datacenter = "dc1"

data_dir = "/tmp/consul/client"

#encrypt = "/3qcep3JKkR3I0jk19KaNrT3YdiM3Op25aW0tBmIs1Y="

#Set the IP address
bind_addr = "{{ GetPrivateIP }}"

retry_join = ["{{ GetPrivateIP }}"]