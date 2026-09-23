variable "web_server_port" {
  description = "Puertos del servidor según el entorno"
  type        = map(number)
}

variable "frontend_port" {
  type = map(number)
}

variable "backend_port" {
  type = map(number)
}