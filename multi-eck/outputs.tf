output "leader" {
  value     = module.eck-leader
  sensitive = true
}

output "follower" {
  value     = module.eck-follower
  sensitive = true
}