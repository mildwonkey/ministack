variable "consul_host" {}
variable "network" {}

data "docker_registry_image" "vault" {
  name = "vault"
}

resource "docker_image" "vault" {
  name          = data.docker_registry_image.vault.name
  pull_triggers = [data.docker_registry_image.vault.sha256_digest]
}

resource "random_pet" "pet_name" {
  prefix = "vault"
  length = 2
}

# Start a container
resource "docker_container" "vault" {
  name  = random_pet.pet_name.id
  image = docker_image.vault.latest

  networks_advanced {
    name = var.network
  }

  upload {
    content = templatefile("${path.module}/vault-config.json.tpl", { consul_host = var.consul_host })
    file    = "/vault/config/vault-config.json"
  }

  capabilities {
    add = ["IPC_LOCK", "NET_ADMIN", "SYS_PTRACE"]
  }

  ports {
    internal = 8200
    external = 8200
    protocol = "tcp"
  }

  command = ["vault", "server", "-config=/vault/config/vault-config.json"]
}


