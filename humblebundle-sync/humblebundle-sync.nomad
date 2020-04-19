job "humblebundle-sync" {

  datacenters = ["dc1"]

  type = "batch"

  periodic {
    cron = "@daily"
    prohibit_overlap = true
    time_zone = "Europe/London"
  }

  group "humblebundle-sync" {
    count = 1

 
    restart {
      attempts = 1
      interval = "30m"

      delay = "60s"

      mode = "fail"
    }

    task "humblebundle-sync" {
      driver = "docker"

      config {
        image = "192.168.1.178:5000/humblebundle-sync:latest"

        volumes = [
          "/data/humblebundle:/data/humblebundle"
        ]

        cpu_hard_limit = true
      }

      # The "artifact" stanza instructs Nomad to download an artifact from a
      # remote source prior to starting the task. This provides a convenient
      # mechanism for downloading configuration files or data needed to run the
      # task. It is possible to specify the "artifact" stanza multiple times to
      # download multiple artifacts.
      #
      # For more information and examples on the "artifact" stanza, please see
      # the online documentation at:
      #
      #     https://www.nomadproject.io/docs/job-specification/artifact.html
      #
      # artifact {
      #   source = "http://foo.com/artifact.tar.gz"
      #   options {
      #     checksum = "md5:c4aa853ad2215426eb7d70a21922e794"
      #   }
      # }


      # The "logs" stanza instructs the Nomad client on how many log files and
      # the maximum size of those logs files to retain. Logging is enabled by
      # default, but the "logs" stanza allows for finer-grained control over
      # the log rotation and storage configuration.
      #
      # For more information and examples on the "logs" stanza, please see
      # the online documentation at:
      #
      #     https://www.nomadproject.io/docs/job-specification/logs.html
      #
      # logs {
      #   max_files     = 10
      #   max_file_size = 15
      # }

      resources {
        cpu    = 300 # 300 MHz
        memory = 32 # 32MB

        network {
          mbits = 25
        }
      }

      kill_timeout = "30s"
    }
  }
}