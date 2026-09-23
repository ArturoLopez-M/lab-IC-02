resource "docker_image" "frontend" {
  name = "nginx:latest"
}

resource "docker_container" "frontend" {
  name  = "frontend-iac"
  image = docker_image.frontend.image_id

  ports {
    external = var.frontend_port[terraform.workspace]
    internal = 80
  }
}