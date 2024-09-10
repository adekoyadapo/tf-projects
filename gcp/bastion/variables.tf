variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "network_name" {
  type    = string
  default = "demo"
}

variable "subnets" {
  type = map(object({
    name = string
    cidr = string
  }))
  default = {
    "demo" = {
      name = "demo"
      cidr = "10.0.10.0/24"
    }
  }
}

variable "machine_type" {
  type    = string
  default = "n1-standard-1"
}

variable "disk_size_gb" {
  type    = string
  default = "50"
}

variable "labels" {
  type = map(string)
  default = {
    "created_by" = "terraform"
    "managed_by" = "ade"
  }
}