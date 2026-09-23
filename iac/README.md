# Laboratorio IC-02 - Frontend y Backend con Terraform

## Objetivo
En esta parte del laboratorio configuré una infraestructura básica con Terraform y Docker, considerando dos entornos: DEV y QA. Para ello configuré un contenedor para el frontend y otro para el backend.

## Configuración de los entornos
Primero configuré los puertos mediante variables para poder usar diferentes valores según el entorno.

En `variables.tf` definí los puertos como mapas:

```
variable "frontend_port" { 
    type = map(number) 
}

variable "backend_port" { 
    type = map(number) 
}
```
En `terraform.tfvars` asigné los puertos para cada entorno:
```
frontend_port = { 
    dev = 4001 
    qa = 5001 
} 

backend_port = { 
    dev = 4002 
    qa = 5002 
}
```
De esta forma, cada entorno utiliza sus propios puertos.

## Configuración del frontend
En `frontend.tf` configuré una imagen de Nginx y un contenedor para el frontend:
```
resource "docker_image" "frontend" { 
    name = "nginx:latest" 
} 
resource "docker_container" "frontend" { 
    name = "frontend-iac" 
    image = docker_image.frontend.image_id 
ports { 
    external = var.frontend_port[terraform.workspace] 
    internal = 80 
    } 
}
```
Utilicé *terraform.workspace* para que Terraform seleccione automáticamente el puerto correspondiente al entorno en el que estoy trabajando.

## Configuración del backend
En `backend.tf` configuré una imagen de Node.js y un contenedor para el backend:
```
resource "docker_image" "backend" { 
    name = "node:22-alpine" 
} 
resource "docker_container" "backend" { 
    name = "backend-iac" 
    image = docker_image.backend.image_id 
ports { 
    external = var.backend_port[terraform.workspace] 
    internal = 3000 
    } 
}
```
En este caso solo configuré la infraestructura del backend. No agregué una aplicación Node.js, por lo que el contenedor puede aparecer como detenido al ejecutarse.

## Uso de Workspaces
Para probar trabajar con uno de los dos entornos (dev) utilicé Terraform Workspaces:
```
terraform workspace new dev 
terraform workspace select dev
```
Al querer cambiar de workspace, Terraform utilizará los puertos definidos para ese entorno.

## Comandos utilizados
Para comprobar la configuración utilicé:
```
terraform plan 
terraform apply
```
También revisé los contenedores con Docker:
```
docker ps 
docker ps -a 
docker logs backend-iac
```
Para comprobar el frontend  (dev) utilicé:
```
curl.exe -i http://localhost:4001
```
## Resultado
Con esta configuración dejé definidos los recursos básicos del frontend y backend, utilizando Docker como plataforma y Terraform para administrar los recursos. Los Workspaces permitirán cambiar entre dev y qa utilizando los puertos correspondientes.

