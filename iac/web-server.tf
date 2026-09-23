# resource "docker_container" "nginx" {
# name  = "nginx-iac-lab02"
#  image = docker_image.nginx.image_id
#  ports {
#    external = var.web_server_port[terraform.workspace]
#    internal = 80
#  }
#}