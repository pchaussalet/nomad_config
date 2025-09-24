job "litellm" {
  datacenters = ["home"]

  type = "service"

  group "litellm" {
    network {
      port "http" {
        to = 4000
      }
    }

    service {
      port = "http"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.http.rule=Path(`/litellm`)",
      ]
    }

    task "litellm-proxy" {
      driver = "docker"

      config {
        image = "ghcr.io/berriai/litellm:main-stable"
      }
    }

    task "litellm-db" {
      driver = "docker"

      config {
        image = "postgres:16"
      }
    }
  }
}
