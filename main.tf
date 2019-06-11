module "network" {
  source = "./modules/network"
}

module "consul_container" {
  source  = "./modules/consul"
  network = module.network.docker_network
}

module "vault_container" {
  source      = "./modules/vault"
  network     = module.network.docker_network
  consul_host = module.consul_container.container_name
}

output "consul_container" {
  value = module.consul_container.container_name
}

output "vault_container" {
  value = module.vault_container.container_name
}
