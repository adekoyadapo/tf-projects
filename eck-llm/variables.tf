variable "cluster_name" {
  type        = string
  description = "cluster_name"
  default     = "demo"
}

variable "cluster_image" {
  type        = string
  description = "Cluster iamge"
  default     = "rancher/k3s:v1.27.4-k3s1"
}

variable "dir" {
  type        = string
  description = "ECK dir"
  default     = "quickstart"
}
variable "helm_release" {
  description = "Helm realease deployment"
  type = map(object({
    repository       = string
    chart            = string
    namespace        = optional(string, "default")
    values           = optional(list(string), [])
    create_namespace = optional(bool, true)
    version          = optional(string)
    set_values = optional(list(object({
      name  = string
      value = string
    })), [])
  }))
  default = {
    "wordpress" = {
      repository = "oci://registry-1.docker.io/bitnamicharts"
      chart      = "wordpress"
      namespace  = "wordpress"
    }
  }
}

variable "username" {
  description = "default user for elastic"
  default     = "elastic"
  type        = string
}