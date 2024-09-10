# eck-llm

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_external"></a> [external](#requirement\_external) | 2.3.3 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.10.1 |
| <a name="requirement_htpasswd"></a> [htpasswd](#requirement\_htpasswd) | 1.2.1 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 3.4.4 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 1.14 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.22.0 |
| <a name="requirement_minikube"></a> [minikube](#requirement\_minikube) | 0.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | 2.3.3 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.10.1 |
| <a name="provider_htpasswd"></a> [htpasswd](#provider\_htpasswd) | 1.2.1 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.4 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | ~> 1.14 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.22.0 |
| <a name="provider_minikube"></a> [minikube](#provider\_minikube) | 0.4.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.charts](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [htpasswd_password.hash](https://registry.terraform.io/providers/loafoe/htpasswd/1.2.1/docs/resources/password) | resource |
| [kubectl_manifest.eck](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [minikube_cluster.cluster](https://registry.terraform.io/providers/scott-the-programmer/minikube/0.4.0/docs/resources/cluster) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.salt](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [time_sleep.wait](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [external_external.getip](https://registry.terraform.io/providers/hashicorp/external/2.3.3/docs/data-sources/external) | data source |
| [http_http.upload_data](https://registry.terraform.io/providers/hashicorp/http/3.4.4/docs/data-sources/http) | data source |
| [kubernetes_ingress_v1.es](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/ingress_v1) | data source |
| [kubernetes_ingress_v1.kb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/ingress_v1) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_image"></a> [cluster\_image](#input\_cluster\_image) | Cluster iamge | `string` | `"rancher/k3s:v1.27.4-k3s1"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | cluster\_name | `string` | `"demo"` | no |
| <a name="input_dir"></a> [dir](#input\_dir) | ECK dir | `string` | `"quickstart"` | no |
| <a name="input_helm_release"></a> [helm\_release](#input\_helm\_release) | Helm realease deployment | <pre>map(object({<br>    repository       = string<br>    chart            = string<br>    namespace        = optional(string, "default")<br>    values           = optional(list(string), [])<br>    create_namespace = optional(bool, true)<br>    version          = optional(string)<br>    set_values = optional(list(object({<br>      name  = string<br>      value = string<br>    })), [])<br>  }))</pre> | <pre>{<br>  "wordpress": {<br>    "chart": "wordpress",<br>    "namespace": "wordpress",<br>    "repository": "oci://registry-1.docker.io/bitnamicharts"<br>  }<br>}</pre> | no |
| <a name="input_username"></a> [username](#input\_username) | default user for elastic | `string` | `"elastic"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_es-url"></a> [es-url](#output\_es-url) | n/a |
| <a name="output_kb-url"></a> [kb-url](#output\_kb-url) | n/a |
| <a name="output_password"></a> [password](#output\_password) | n/a |
<!-- END_TF_DOCS -->
