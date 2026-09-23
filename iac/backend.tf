resource "docker_image" "backend" {
  name = "node:22-alpine"
}

resource "docker_container" "backend" {
  name  = "backend-iac"
  image = docker_image.backend.image_id

  ports {
    external = var.backend_port[terraform.workspace]
    internal = 3000
  }
}