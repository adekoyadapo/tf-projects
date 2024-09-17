variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "prefix" {
  type    = string
  default = "private"
}

variable "labels" {
  type = map(string)
  default = {
    "created_by" = "terraform"
    "managed_by" = "ade"
  }
}

variable "buckets" {
  type    = list(string)
  default = ["nginxconfig", "webfiles"]

}

variable "image_url" {
  description = "The container image URL"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
  default     = 8501

}

variable "network_name" {
  type    = string
  default = "demo"
}

variable "subnets" {
  type = map(object({
    name        = string
    cidr        = string
    description = optional(string)
    purpose     = optional(string)
  }))
  default = {
    "demo" = {
      name        = "demo"
      cidr        = "10.0.10.0/24"
      description = "demo subnet"
      purpose     = "INTERNAL_HTTPS_LOAD_BALANCER"
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
