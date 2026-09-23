terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "4.6.0"
    }
  }
}

provider "docker" {
  # Configuration options
}


# Find the latest Nginx precise image.
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

output "image_id"{
    value= docker_image.nginx.image_id
}