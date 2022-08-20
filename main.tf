#Create a docker image resource
#-> docker pull nginx:latest
resource "docker_image" "nginx" {
  name = "nginx:latest"
  keep_locally = true
}



# Create a docker container resource
# -> same as 'docker run --name nginx -p8080:80 -d nginx:latest'
resource "docker_container" "nginx1" {
  name    = "nginx1"
  image   = docker_image.nginx.latest

  ports {
    external = 8085
    internal = 80
  }
}


resource "docker_image" "httpd" {
  name = "httpd:latest"
  keep_locally = true
}

variable "container_names" {
  default = {
    "a"=8081,
    "b"=8082,
    "c"=8083
    }
}

resource "docker_container" "my_apache" {
  image = docker_image.httpd.latest
  for_each = var.container_names
  name = "apache-${each.key}"
  ports {
        external = each.value
        internal = 80
      }
	 
    
}

output "my_output" {
  value = docker_container.my_apache
}


# Use a loca Ubuntu image.
resource "docker_image" "ub" {
  name = "ubuntu_update_ping:1.0.0"
}

resource "docker_container" "ubc" {
  image = docker_image.ub.latest
  name  = "u2"  
  entrypoint = ["bin/bash"]
  tty = true
  stdin_open = true
  
}