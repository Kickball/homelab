job "smokeping" {
  datacenters = ["locc"]

  type = "service"

  update {
    max_parallel = 1
    min_healthy_time = "30s"
    healthy_deadline = "3m"
    progress_deadline = "10m"
    auto_revert = false
    canary = 0
  }

  migrate {
    max_parallel = 1

    health_check = "checks"

    min_healthy_time = "10s"

    healthy_deadline = "5m"
  }

  group "smokeping" {
    count = 1

    restart {
      attempts = 2

      interval = "30m"

      delay = "120s"

      mode = "fail"
    }

    volume "config" {
      type      = "host"
      source    = "smokeping-config"
      read_only = true
    }

    volume "data" {
      type      = "host"
      source    = "smokeping-data"
      read_only = false
    }

    task "smokeping" {
      driver = "podman"

      env {
        PUID = "1000"
        PGID = "1000"
        TZ   = "Europe/London"
      }

      config {
        image = "smokeping:latest"

        port_map {
          http = 80
        }
      }


      resources {
        #MHz
        cpu    = 250
        #MB
        memory = 500

        network {
          mbits = 15
          port  "http"  {
            static = "8080"
          }
        }
      }

      # Controls the timeout between signalling a task it will be killed
      # and killing the task. If not set a default is used.
      kill_timeout = "30s"
    }
  }
}
