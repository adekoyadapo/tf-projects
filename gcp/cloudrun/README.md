# cloudrun

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

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_region_network_endpoint_group.serverless_neg](https://registry.terraform.io/providers/hashicorp/google-beta/5.36.0/docs/resources/google_compute_region_network_endpoint_group) | resource |
| [google-beta_google_project_service_identity.iap_sa](https://registry.terraform.io/providers/hashicorp/google-beta/5.36.0/docs/resources/google_project_service_identity) | resource |
| [google_cloud_run_v2_service.main](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/cloud_run_v2_service) | resource |
| [google_cloud_run_v2_service_iam_member.public-access](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/cloud_run_v2_service_iam_member) | resource |
| [google_iap_client.iap_client](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/iap_client) | resource |
| [google_iap_web_iam_member.iap_iam](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/iap_web_iam_member) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_openai_api_key"></a> [azure\_openai\_api\_key](#input\_azure\_openai\_api\_key) | Azure OpenAI API Key value | `string` | n/a | yes |
| <a name="input_azure_openai_deployment_name"></a> [azure\_openai\_deployment\_name](#input\_azure\_openai\_deployment\_name) | Azure OpenAI Deployment Name value | `string` | n/a | yes |
| <a name="input_azure_openai_endpoint"></a> [azure\_openai\_endpoint](#input\_azure\_openai\_endpoint) | Azure OpenAI Endpoint value | `string` | n/a | yes |
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | Cloud ID value | `string` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Container port | `number` | `8501` | no |
| <a name="input_es_api_key"></a> [es\_api\_key](#input\_es\_api\_key) | Elasticsearch API Key value | `string` | n/a | yes |
| <a name="input_iap_brand_name"></a> [iap\_brand\_name](#input\_iap\_brand\_name) | IAP Brand Name value - format: projects/{project\_number}/brands/{brand\_id} | `string` | n/a | yes |
| <a name="input_iap_email"></a> [iap\_email](#input\_iap\_email) | IAP Email value | `string` | `"ade.adekoya@elastic.co"` | no |
| <a name="input_iap_oauth2_client_name"></a> [iap\_oauth2\_client\_name](#input\_iap\_oauth2\_client\_name) | IAP OAuth2 Client Name value | `string` | `"iap-client-cloudrun"` | no |
| <a name="input_image_url"></a> [image\_url](#input\_image\_url) | The container image URL | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | <pre>{<br>  "created_by": "terraform",<br>  "managed_by": "ade"<br>}</pre> | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"elb"` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudrun"></a> [cloudrun](#output\_cloudrun) | n/a |
| <a name="output_ip"></a> [ip](#output\_ip) | n/a |
<!-- END_TF_DOCS -->
