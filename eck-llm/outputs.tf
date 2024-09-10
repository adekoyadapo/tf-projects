output "password" {
  value     = htpasswd_password.hash.sha256
  sensitive = true
}

output "kb-url" {
  value = data.kubernetes_ingress_v1.kb.spec.0.rule.0.host
}

output "es-url" {
  value = try(data.kubernetes_ingress_v1.es[0].spec.0.rule.0.host, null)
}