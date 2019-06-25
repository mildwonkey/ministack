// create a volume
resource "null_resource" "consul_directory" {
  provisioner "local-exec" {
    command = "mkdir -p /tmp/consul-data"
  }
}

resource "random_pet" "pet_name" {
  prefix = "consul"
  length = 2
}

data "docker_registry_image" "consul" {
  name = "consul"
}

resource "docker_image" "consul" {
  name          = data.docker_registry_image.consul.name
  pull_triggers = [data.docker_registry_image.consul.sha256_digest]
}

# Start a container
resource "docker_container" "consul" {
  depends_on = [null_resource.consul_directory]
  name       = random_pet.pet_name.id
  hostname   = "consul"
  image      = docker_image.consul.latest
  volumes {
    host_path      = "/tmp/consul-data"
    container_path = "/consul/data"
  }
  networks_advanced {
    name = var.network.name
  }

  env = [
    "CONSUL_HTTP_TOKEN=supersecure"
  ]

  dynamic "ports" {
    for_each = "${var.consul_ports}"
    content {
      protocol = ports.value.protocol
      internal = ports.value.internal
      external = ports.value.external
    }
  }
}

output "consul_container" {
  value = docker_container.consul
}
