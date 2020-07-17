storage "consul" {
  address = "192.168.1.178:8500"
  path    = "vault/"
}

listener "tcp" {
  #"192.168.1.178:8200"
 address     = "{{ GetPrivateIP }}" 
 tls_disable = 1
}

ui = true