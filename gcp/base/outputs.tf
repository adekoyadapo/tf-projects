output "service_accounts" {
  value = module.service_accounts.iam_emails
}

output "service_account_email" {
  value = module.service_accounts.email
}

output "sa_keys" {
  value     = module.service_accounts.keys
  sensitive = true
}

output "bucket_name" {
  value = module.cloud_storage.name
}
