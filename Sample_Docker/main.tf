# Define provider for Docker
provider "docker" {
    
} 
# Create network for the containers to communicate
resource "docker_network" "app_network" { 
    name = "app_network"
} 
# Create database container
resource "docker_container" "db_container" {
    name = "db_container"
    image = "mysql:latest"
    env = ["MYSQL_ROOT_PASSWORD=password"]
    ports {
      internal = 3306
    }
    network_advanced {
      name = docker_network.app_network.name
      static_ip = "172.20.0.2"
    } 
}
# Create web application container
resource "docker_container" "web_container" { 
    name = "web_container" 
    image = "nginx:latest" 
    ports { 
        internal = 80 
        } 
    network_advanced { 
        name = docker_network.app_network.name 
        static_ip = "172.20.0.3" 
        }
 } 
 # Create API container
 resource "docker_container" "api_container" { 
    name = "api_container" 
    image = "node:latest" 
    ports { 
        internal = 3000 
        }
    network_advanced { 
        name = docker_network.app_network.name 
        static_ip = "172.20.0.4"
        }
}