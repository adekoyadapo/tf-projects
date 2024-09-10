# resource "random_string" "suffix" {
#   length  = 4
#   upper   = false
#   special = false
# }

# module "log_export" {
#   source  = "terraform-google-modules/log-export/google"
#   version = "~> 8.1"

#   destination_uri        = module.destination.destination_uri
#   filter                 = "resource.type = http_load_balancer"
#   log_sink_name          = "pubsub_project_${random_string.suffix.result}"
#   parent_resource_id     = var.project
#   parent_resource_type   = "project"
#   unique_writer_identity = true
# }

# module "destination" {
#   source  = "terraform-google-modules/log-export/google//modules/pubsub"
#   version = "~> 8.1"

#   project_id               = var.project
#   topic_labels             = { topic_key : "topic_label" }
#   topic_name               = "pubsub-project-${random_string.suffix.result}"
#   log_sink_writer_identity = module.log_export.writer_identity
#   create_subscriber        = true
#   subscription_labels      = { subscription_key : "subscription_label" }
# }