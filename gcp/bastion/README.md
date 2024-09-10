# bastion

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
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
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
| [google_compute_firewall.allow_access_from_bastion](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/compute_firewall) | resource |
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/compute_router) | resource |
| [google_storage_bucket_object.default](https://registry.terraform.io/providers/hashicorp/google/5.36.0/docs/resources/storage_bucket_object) | resource |
| [local_file.random_paragraph_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.random_paragraph_pet_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [random_pet.random_paragraph_pet](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_string.random_paragraph](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [terraform_remote_state.local](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | n/a | `string` | `"50"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | <pre>{<br>  "created_by": "terraform",<br>  "managed_by": "ade"<br>}</pre> | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | n/a | `string` | `"n1-standard-1"` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | n/a | `string` | `"demo"` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | <pre>map(object({<br>    name = string<br>    cidr = string<br>  }))</pre> | <pre>{<br>  "demo": {<br>    "cidr": "10.0.10.0/24",<br>    "name": "demo"<br>  }<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
