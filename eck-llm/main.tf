locals {
  manifests = {
    for fn in fileset("${path.module}/${var.dir}", "*.yml") :
    fn => templatefile("${path.module}/${var.dir}/${fn}", {
      domain   = data.external.getip.result.sslip_io
      username = var.username
      password = htpasswd_password.hash.sha256
    })
    # if fn != "fleet.yml" # Skip the fleet.yml file
  }
}


resource "random_password" "password" {
  length           = 30
  special          = false
  override_special = "!#$%&*()-_=+[]{}<>:?@"
}

resource "random_password" "salt" {
  length           = 8
  special          = true
  override_special = "!@#%&*()-_=+[]{}<>:?"
}

resource "htpasswd_password" "hash" {
  password = random_password.password.result
  salt     = random_password.salt.result
}

resource "minikube_cluster" "cluster" {
  vm                = true
  driver            = "qemu"
  cluster_name      = var.cluster_name
  nodes             = 2
  cni               = "bridge"
  network           = "socket_vmnet"
  container_runtime = "cri-o"
  delete_on_failure = true
  memory            = "16gb"
  cpus              = 8
  addons = [
    "dashboard",
    "ingress",
    "storage-provisioner",
    "default-storageclass"
  ]
}

data "external" "getip" {
  program    = ["bash", "${path.module}/getip.sh", var.cluster_name]
  depends_on = [minikube_cluster.cluster]
}

resource "helm_release" "charts" {
  for_each = var.helm_release
  name     = each.key

  repository       = each.value.repository
  chart            = each.value.chart
  namespace        = each.value.namespace
  version          = each.value.version
  create_namespace = true

  values  = fileexists("${path.module}/values/${each.key}.yaml") ? templatefile("${path.module}/values/${each.key}.yaml", ) : null
  timeout = 120

  dynamic "set" {
    for_each = each.value.set_values

    content {
      name  = set.value["name"]
      value = set.value["value"]
    }
  }
}

resource "kubectl_manifest" "eck" {
  for_each = {
    for k, v in local.manifests : k => v
  }

  yaml_body = each.value

  depends_on = [helm_release.charts, ]
}

data "kubernetes_ingress_v1" "kb" {
  metadata {
    name      = "kibana-ingress"
    namespace = "default"
  }
  depends_on = [helm_release.charts, time_sleep.wait]
}

data "kubernetes_ingress_v1" "es" {
  count = length(regexall("quickstart|non", var.dir)) > 0 ? 1 : 0
  metadata {
    name      = "elasticsearch-ingress"
    namespace = "default"
  }
  depends_on = [helm_release.charts, time_sleep.wait]
}

resource "time_sleep" "wait" {
  depends_on = [kubectl_manifest.eck]

  create_duration = "180s"
}

data "http" "upload_data" {
  count  = length(regexall("quickstart|non", var.dir)) > 0 ? 1 : 0
  url    = "http://${data.kubernetes_ingress_v1.es[0].spec.0.rule.0.host}/_bulk"
  method = "POST"
  request_headers = {
    Content-Type  = "application/x-ndjson"
    Authorization = "Basic ${base64encode("${var.username}:${htpasswd_password.hash.sha256}")}"
  }

  retry {
    attempts = 5
  }

  request_body = file("${path.module}/computing.ndjson")
  depends_on   = [time_sleep.wait]

}