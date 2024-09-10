# base

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.36.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 5.36.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.36.0 |
| <a name="provider_local"></a> [local](#provider\_local) | ~> 2.5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_storage"></a> [cloud\_storage](#module\_cloud\_storage) | terraform-google-modules/cloud-storage/google | ~> 6.0.0 |
| <a name="module_service_accounts"></a> [service\_accounts](#module\_service\_accounts) | terraform-google-modules/service-accounts/google | ~> 4.2 |

## Resources

| Name | Type |
|------|------|
| [google_project_service.project](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/project_service) | resource |
| [local_sensitive_file.sa_keys](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | n/a | `list(string)` | <pre>[<br>  "compute.googleapis.com"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | n/a |
| <a name="output_sa_keys"></a> [sa\_keys](#output\_sa\_keys) | n/a |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | n/a |
| <a name="output_service_accounts"></a> [service\_accounts](#output\_service\_accounts) | n/a |
<!-- END_TF_DOCS -->
