variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "cluster_name" {
  type    = string
  default = "ecs-gke"
}

variable "labels" {
  type = map(string)
  default = {
    "created_by" = "terraform"
    "managed_by" = "ade"
  }
}
variable "network_name" {
  type    = string
  default = "gke-eck"
}

variable "subnets" {
  type = map(object({
    cidr = string
  }))
  default = {
    "nodes" = {
      cidr = "10.0.10.0/24"
    }
  }
}

variable "secondary_ranges" {
  type = map(list(object({
    range_name    = string
    ip_cidr_range = string
  })))
  default = {
    "gke-nodes" = [{
      range_name    = "gke-services"
      ip_cidr_range = "10.0.11.0/24"
    }]
  }
}

variable "rolesList" {
  type        = list(string)
  description = "List of roles required by the GKE service account"

  default = [
    "roles/storage.objectViewer",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/compute.osLogin"
  ]
}

variable "service_account_roles_supplemental" {
  type        = list(string)
  description = "Supplementary list of roles for bastion host"
  default = [
    "roles/container.developer"
  ]
}

variable "remove_default_node_pool" {
  type        = bool
  default     = true
  description = "Remove the default node pool created by GKE"
}

variable "cluster_autoscaling" {
  type = object({
    enabled                     = bool
    autoscaling_profile         = string
    min_cpu_cores               = number
    max_cpu_cores               = number
    min_memory_gb               = number
    max_memory_gb               = number
    gpu_resources               = list(object({ resource_type = string, minimum = number, maximum = number }))
    auto_repair                 = bool
    auto_upgrade                = bool
    disk_size                   = optional(number)
    disk_type                   = optional(string)
    image_type                  = optional(string)
    strategy                    = optional(string)
    max_surge                   = optional(number)
    max_unavailable             = optional(number)
    node_pool_soak_duration     = optional(string)
    batch_soak_duration         = optional(string)
    batch_percentage            = optional(number)
    batch_node_count            = optional(number)
    enable_secure_boot          = optional(bool, false)
    enable_integrity_monitoring = optional(bool, true)
  })
  default = {
    enabled                     = true
    autoscaling_profile         = "BALANCED"
    max_cpu_cores               = 64
    min_cpu_cores               = 0
    max_memory_gb               = 256
    min_memory_gb               = 0
    gpu_resources               = []
    auto_repair                 = true
    auto_upgrade                = true
    disk_size                   = 50
    disk_type                   = "pd-standard"
    image_type                  = "COS_CONTAINERD"
    enable_secure_boot          = false
    enable_integrity_monitoring = true
  }
  description = "Cluster autoscaling configuration. See [more details](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#clusterautoscaling)"
}

variable "create_kubeconfig" {
  default = true
  type    = bool
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "email" {
  type        = string
  default     = "elastic"
  description = "Please, enter your email (elastic email) or a user"
}
