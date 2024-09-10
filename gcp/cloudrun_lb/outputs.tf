output "lb_ip" {
  value = module.lb-http.external_ip
}

# output "pubsub_topic" {
#   value = module.destination.pubsub_subscription
# }

output "sa_json" {
  value     = module.service_accounts.keys["ecs"]
  sensitive = true
}