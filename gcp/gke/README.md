# gke

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.36.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 5.36.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.15.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 1.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.32.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.36.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.15.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.14.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.32.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke_auth"></a> [gke\_auth](#module\_gke\_auth) | terraform-google-modules/kubernetes-engine/google//modules/auth | 23.3.0 |
| <a name="module_subnets"></a> [subnets](#module\_subnets) | terraform-google-modules/network/google//modules/subnets | ~> 9.1 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google//modules/vpc | ~> 9.1 |

## Resources

| Name | Type |
|------|------|
| [google_container_cluster.main](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/container_cluster) | resource |
| [google_project_iam_member.sa_iam](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/project_iam_member) | resource |
| [google_service_account.cluster_serviceaccount](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/service_account) | resource |
| [helm_release.elastic](https://registry.terraform.io/providers/hashicorp/helm/2.15.0/docs/resources/release) | resource |
| [kubectl_manifest.eck](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubernetes_cluster_role_binding.cluster-admin-binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.32.0/docs/resources/cluster_role_binding) | resource |
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [time_sleep.wait_30_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [google_client_config.main](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/data-sources/client_config) | data source |
| [google_container_cluster.main](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/data-sources/container_cluster) | data source |
| [google_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/data-sources/iam_role) | data source |
| [kubectl_path_documents.docs](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/data-sources/path_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_autoscaling"></a> [cluster\_autoscaling](#input\_cluster\_autoscaling) | Cluster autoscaling configuration. See [more details](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#clusterautoscaling) | <pre>object({<br>    enabled                     = bool<br>    autoscaling_profile         = string<br>    min_cpu_cores               = number<br>    max_cpu_cores               = number<br>    min_memory_gb               = number<br>    max_memory_gb               = number<br>    gpu_resources               = list(object({ resource_type = string, minimum = number, maximum = number }))<br>    auto_repair                 = bool<br>    auto_upgrade                = bool<br>    disk_size                   = optional(number)<br>    disk_type                   = optional(string)<br>    image_type                  = optional(string)<br>    strategy                    = optional(string)<br>    max_surge                   = optional(number)<br>    max_unavailable             = optional(number)<br>    node_pool_soak_duration     = optional(string)<br>    batch_soak_duration         = optional(string)<br>    batch_percentage            = optional(number)<br>    batch_node_count            = optional(number)<br>    enable_secure_boot          = optional(bool, false)<br>    enable_integrity_monitoring = optional(bool, true)<br>  })</pre> | <pre>{<br>  "auto_repair": true,<br>  "auto_upgrade": true,<br>  "autoscaling_profile": "BALANCED",<br>  "disk_size": 50,<br>  "disk_type": "pd-standard",<br>  "enable_integrity_monitoring": true,<br>  "enable_secure_boot": false,<br>  "enabled": true,<br>  "gpu_resources": [],<br>  "image_type": "COS_CONTAINERD",<br>  "max_cpu_cores": 64,<br>  "max_memory_gb": 256,<br>  "min_cpu_cores": 0,<br>  "min_memory_gb": 0<br>}</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | `"ecs-gke"` | no |
| <a name="input_create_kubeconfig"></a> [create\_kubeconfig](#input\_create\_kubeconfig) | n/a | `bool` | `true` | no |
| <a name="input_email"></a> [email](#input\_email) | Please, enter your email (elastic email) or a user | `string` | `"elastic"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | <pre>{<br>  "created_by": "terraform",<br>  "managed_by": "ade"<br>}</pre> | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | n/a | `string` | `"e2-medium"` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | n/a | `string` | `"gke-eck"` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_remove_default_node_pool"></a> [remove\_default\_node\_pool](#input\_remove\_default\_node\_pool) | Remove the default node pool created by GKE | `bool` | `true` | no |
| <a name="input_rolesList"></a> [rolesList](#input\_rolesList) | List of roles required by the GKE service account | `list(string)` | <pre>[<br>  "roles/storage.objectViewer",<br>  "roles/logging.logWriter",<br>  "roles/monitoring.metricWriter",<br>  "roles/monitoring.viewer",<br>  "roles/compute.osLogin"<br>]</pre> | no |
| <a name="input_secondary_ranges"></a> [secondary\_ranges](#input\_secondary\_ranges) | n/a | <pre>map(list(object({<br>    range_name    = string<br>    ip_cidr_range = string<br>  })))</pre> | <pre>{<br>  "gke-nodes": [<br>    {<br>      "ip_cidr_range": "10.0.11.0/24",<br>      "range_name": "gke-services"<br>    }<br>  ]<br>}</pre> | no |
| <a name="input_service_account_roles_supplemental"></a> [service\_account\_roles\_supplemental](#input\_service\_account\_roles\_supplemental) | Supplementary list of roles for bastion host | `list(string)` | <pre>[<br>  "roles/container.developer"<br>]</pre> | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | <pre>map(object({<br>    cidr = string<br>  }))</pre> | <pre>{<br>  "nodes": {<br>    "cidr": "10.0.10.0/24"<br>  }<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
