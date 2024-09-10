variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "prefix" {
  type    = string
  default = "elb"
}

variable "labels" {
  type = map(string)
  default = {
    "created_by" = "terraform"
    "managed_by" = "ade"
  }
}