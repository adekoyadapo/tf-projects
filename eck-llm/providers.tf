terraform {
  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "0.4.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.3.3"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.10.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.22.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.4"
    }
    htpasswd = {
      source  = "loafoe/htpasswd"
      version = "1.2.1"
    }
  }
}

provider "minikube" {
  kubernetes_version = "v1.30.0"
}

provider "helm" {
  kubernetes {
    client_certificate     = minikube_cluster.cluster.client_certificate
    host                   = minikube_cluster.cluster.host
    client_key             = minikube_cluster.cluster.client_key
    cluster_ca_certificate = minikube_cluster.cluster.cluster_ca_certificate
  }
}

provider "kubectl" {
  client_certificate     = minikube_cluster.cluster.client_certificate
  host                   = minikube_cluster.cluster.host
  client_key             = minikube_cluster.cluster.client_key
  cluster_ca_certificate = minikube_cluster.cluster.cluster_ca_certificate
  load_config_file       = false
}

provider "kubernetes" {
  client_certificate     = minikube_cluster.cluster.client_certificate
  host                   = minikube_cluster.cluster.host
  client_key             = minikube_cluster.cluster.client_key
  cluster_ca_certificate = minikube_cluster.cluster.cluster_ca_certificate
}