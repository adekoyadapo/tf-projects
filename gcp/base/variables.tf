variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "service" {
  type    = list(string)
  default = ["compute.googleapis.com"]
}
