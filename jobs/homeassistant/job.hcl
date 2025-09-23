# Use Nomad Variables to modify this job's output:
# run "nomad var put nomad/jobs/variables-example name=YOUR_NAME" to get started

job "homeassistant" {
  # Specifies the datacenter where this job should be run
  # This can be omitted and it will default to ["*"]
  datacenters = ["home"]

  group "homeassistant" {

    network {
      # Task group will have an isolated network namespace with
      # an interface that is bridged with the host
      port "www" {
        static = 8123
      }
    }

    task "ha-core" {

      driver = "docker"

      config {
        image   = "ghcr.io/home-assistant/home-assistant:stable"
        network_mode = "host"
        privileged = true
        ports   = ["www"]
      }

      service {
        provider = "nomad"
        port     = "www"
        
        tags = [
          "traefik.enable=true"
        ]
      }

      resources {
        cpu    = 1000
        memory = 512
      }

    }
  }
}

