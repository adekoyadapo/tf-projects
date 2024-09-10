output "cloudrun" {
  value = google_cloud_run_v2_service.main.uri
}

output "ip" {
  value = module.lb-http.external_ip
}