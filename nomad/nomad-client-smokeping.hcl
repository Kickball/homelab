client {
  host_volume "smokeping-config" {
      path      = "/data/smokeping/config"
      read_only = true
  }
  host_volume "smokeping-data" {
      path      = "/data/smokeping/data"
      read_only = false
  }
}
