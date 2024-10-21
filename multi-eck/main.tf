module "eck-leader" {
  source        = "../eck-llm"
  dir           = var.dir
  cluster_name  = "leader-eck"
  cluster_image = "rancher/k3s:v1.30.4-k3s1"
  username      = "ccr"
}

module "eck-follower" {
  source        = "../eck-llm"
  dir           = var.dir
  cluster_name  = "follower-eck"
  cluster_image = "rancher/k3s:v1.30.4-k3s1"
  username      = "ccr"
  upload_data   = false
}