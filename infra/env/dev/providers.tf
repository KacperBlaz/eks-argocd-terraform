terraform {
  backend "s3" {}

  required_version = ">=0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  config_path            = "~/.kube/config"
  host                   = module.main
  cluster_ca_certificate = base64decode(module.main.kubeconfig_cert_authority_data)
}

provider "kubectl" {
  config_path            = "~/.kube/config"
  host                   = module.main
  cluster_ca_certificate = base64decode(module.main.kubeconfig_cert_authority_data)
  alias = "kubectl-provider"
}

provider "helm" {
  kubernetes {
    config_path            = "~/.kube/config"
  }
}
