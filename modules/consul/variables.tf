variable "network" {
  description = "An entire `docker_network` resource"
}

variable "consul_ports" {
  type = list(object({
    internal = number,
    external = number,
    protocol = string
  }))
  default = [
    {
      internal = 8300
      external = 8300
      protocol = "tcp"
    },
    {
      internal = 8301
      external = 8301
      protocol = "tcp"
    },
    {
      internal = 8301
      external = 8301
      protocol = "udp"
    },
    {
      internal = 8302
      external = 8302
      protocol = "tcp"
    },
    {
      internal = 8302
      external = 8302
      protocol = "udp"
    },
    {
      internal = 8400
      external = 8400
      protocol = "tcp"
    },
    {
      internal = 8500
      external = 8500
      protocol = "tcp"
    },
    {
      internal = 8600
      external = 8600
      protocol = "tcp"
    },
    {
      internal = 8600
      external = 53
      protocol = "udp"
    }
  ]
}
