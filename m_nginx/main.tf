terraform {
  required_providers {
    # We recommend pinning to the specific version of the Docker Provider you're using
    # since new versions are released frequently
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.13.0"
    }
  }

}

# Configure the docker provider
provider "docker" {
  host = "npipe:////.//pipe//docker_engine" 
}



#Create a docker image resource
#-> docker pull nginx:latest
resource "docker_image" "nginx" {
  name = "nginx:latest"
  keep_locally = true
}



# Create a docker container resource
# -> same as 'docker run --name nginx -p8080:80 -d nginx:latest'
resource "docker_container" "nginx12" {
  name    = "nginx-${var.port}"
  image   = docker_image.nginx.latest

  ports {
    external = var.port
    internal = 80
  }
}
