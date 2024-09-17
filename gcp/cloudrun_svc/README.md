# cloudrun_svc

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.36.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 5.36.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.36.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 5.36.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket"></a> [bucket](#module\_bucket) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | ~> 6.1 |
| <a name="module_cloud-nat"></a> [cloud-nat](#module\_cloud-nat) | terraform-google-modules/cloud-nat/google | ~> 5.0 |
| <a name="module_iap_bastion"></a> [iap\_bastion](#module\_iap\_bastion) | terraform-google-modules/bastion-host/google | 6.0.0 |
| <a name="module_subnets"></a> [subnets](#module\_subnets) | terraform-google-modules/network/google//modules/subnets | ~> 9.1 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google//modules/vpc | ~> 9.1 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_forwarding_rule.forwarding_rule](https://registry.terraform.io/providers/hashicorp/google-beta/5.36.0/docs/resources/google_compute_forwarding_rule) | resource |
| [google_cloud_run_v2_service.main](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/cloud_run_v2_service) | resource |
| [google_cloud_run_v2_service_iam_member.public-access](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/cloud_run_v2_service_iam_member) | resource |
| [google_compute_address.lb_internal_ip](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/compute_address) | resource |
| [google_compute_firewall.allow_access_from_bastion](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/compute_firewall) | resource |
| [google_compute_health_check.health-check](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/compute_health_check) | resource |
| [google_compute_region_backend_service.backend-service](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/compute_region_backend_service) | resource |
| [google_compute_region_network_endpoint_group.cloudrun_neg](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/compute_region_network_endpoint_group) | resource |
| [google_compute_region_target_http_proxy.targethttpproxy](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/compute_region_target_http_proxy) | resource |
| [google_compute_region_url_map.regionurlmap](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/compute_region_url_map) | resource |
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/compute_router) | resource |
| [google_storage_bucket_object.upload](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/storage_bucket_object) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/data-sources/project) | data source |
| [terraform_remote_state.local](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_buckets"></a> [buckets](#input\_buckets) | n/a | `list(string)` | <pre>[<br>  "nginxconfig",<br>  "webfiles"<br>]</pre> | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Container port | `number` | `8501` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | n/a | `string` | `"50"` | no |
| <a name="input_image_url"></a> [image\_url](#input\_image\_url) | The container image URL | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | <pre>{<br>  "created_by": "terraform",<br>  "managed_by": "ade"<br>}</pre> | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | n/a | `string` | `"n1-standard-1"` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | n/a | `string` | `"demo"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"private"` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | <pre>map(object({<br>    name        = string<br>    cidr        = string<br>    description = optional(string)<br>    purpose     = optional(string)<br>  }))</pre> | <pre>{<br>  "demo": {<br>    "cidr": "10.0.10.0/24",<br>    "description": "demo subnet",<br>    "name": "demo",<br>    "purpose": "INTERNAL_HTTPS_LOAD_BALANCER"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app"></a> [app](#output\_app) | n/a |
<!-- END_TF_DOCS -->
