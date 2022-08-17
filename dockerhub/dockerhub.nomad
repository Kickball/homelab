# There can only be a single job definition per file. This job is named
# "example" so it will create a job with the ID and Name "example".

# The "job" stanza is the top-most configuration option in the job
# specification. A job is a declarative specification of tasks that Nomad
# should run. Jobs have a globally unique name, one or many task groups, which
# are themselves collections of one or many tasks.
#
# For more information and examples on the "job" stanza, please see
# the online documentation at:
#
#     https://www.nomadproject.io/docs/job-specification/job.html
#
job "dockerhub" {
  # The "region" parameter specifies the region in which to execute the job.
  # If omitted, this inherits the default region name of "global".
  # region = "global"
  #
  # The "datacenters" parameter specifies the list of datacenters which should
  # be considered when placing this task. This must be provided.
  datacenters = ["locc"]

  # The "type" parameter controls the type of job, which impacts the scheduler's
  # decision on placement. This configuration is optional and defaults to
  # "service". For a full list of job types and their differences, please see
  # the online documentation.
  #
  # For more information, please see the online documentation at:
  #
  #     https://www.nomadproject.io/docs/jobspec/schedulers.html
  #
  type = "service"

  # The "update" stanza specifies the update strategy of task groups. The update
  # strategy is used to control things like rolling upgrades, canaries, and
  # blue/green deployments. If omitted, no update strategy is enforced. The
  # "update" stanza may be placed at the job or task group. When placed at the
  # job, it applies to all groups within the job. When placed at both the job and
  # group level, the stanzas are merged with the group's taking precedence.
  #
  # For more information and examples on the "update" stanza, please see
  # the online documentation at:
  #
  #     https://www.nomadproject.io/docs/job-specification/update.html
  #
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
  # The "group" stanza defines a series of tasks that should be co-located on
  # the same Nomad client. Any task within a group will be placed on the same
  # client.
  #
  # For more information and examples on the "group" stanza, please see
  # the online documentation at:
  #
  #     https://www.nomadproject.io/docs/job-specification/group.html
  #
  group "dockerhub" {
    # The "count" parameter specifies the number of the task groups that should
    # be running under this group. This value must be non-negative and defaults
    # to 1.
    count = 1

    restart {
      attempts = 2

      interval = "30m"

      delay = "120s"

      mode = "fail"
    }

    task "dockerhub" {
      driver = "podman"
      #driver = "docker"

      config {
        image = "registry:latest"

        port_map {
          https = 5000
        }
      }


      resources {
        #MHz
        cpu    = 50
        #MB
        memory = 32

        network {
          mbits = 50
          port  "https"  {
            static = "5000"
          }
        }
      }

      # The "service" stanza instructs Nomad to register this task as a service
      # in the service discovery engine, which is currently Consul. This will
      # make the service addressable after Nomad has placed it on a host and
      # port.
      #
      # For more information and examples on the "service" stanza, please see
      # the online documentation at:
      #
      #     https://www.nomadproject.io/docs/job-specification/service.html
      #
      service {
        name = "dockerhub"
        tags = ["catalog", "dockerhub"]
        port = "https"

        check {
          name            = "catalog"
          type            = "http"
          protocol        = "http"
          #tls_skip_verify = true
          path            = "/v2/_catalog"
          interval        = "60s"
          timeout         = "5s"
        }
      }

      # Controls the timeout between signalling a task it will be killed
      # and killing the task. If not set a default is used.
      kill_timeout = "30s"
    }
  }
}
