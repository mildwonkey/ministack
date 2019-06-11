resource "docker_network" "private_network" {
  name   = "ministack"
  driver = "bridge"

  ipam_config {
    subnet  = "172.23.0.0/16"
    gateway = "172.23.0.1"
  }
}


// We don't know what attributes are needed, so we'll output the entire resource
output "docker_network" {
  value = docker_network.private_network
}
