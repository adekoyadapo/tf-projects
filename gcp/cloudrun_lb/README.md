# cloudrun_lb

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

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lb-http"></a> [lb-http](#module\_lb-http) | terraform-google-modules/lb-http/google//modules/serverless_negs | 11.0.0 |
| <a name="module_service_accounts"></a> [service\_accounts](#module\_service\_accounts) | terraform-google-modules/service-accounts/google | ~> 4.2 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_region_network_endpoint_group.serverless_neg](https://registry.terraform.io/providers/hashicorp/google-beta/5.36.0/docs/resources/google_compute_region_network_endpoint_group) | resource |
| [google_cloud_run_service.main](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/cloud_run_service) | resource |
| [google_cloud_run_service_iam_member.public-access](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/cloud_run_service_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | <pre>{<br>  "created_by": "terraform",<br>  "managed_by": "ade"<br>}</pre> | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"elb"` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_ip"></a> [lb\_ip](#output\_lb\_ip) | n/a |
| <a name="output_sa_json"></a> [sa\_json](#output\_sa\_json) | n/a |
<!-- END_TF_DOCS -->
