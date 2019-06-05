resource "docker_network" "private_network" {
  name   = "devops"
  driver = "bridge"
}


module "consul_container" {
  source  = "./consul"
  network = docker_network.private_network.name
}

module "vault_container" {
  source      = "./vault"
  network     = docker_network.private_network.name
  consul_host = module.consul_container.container_name
}

// template_file backend config? 

