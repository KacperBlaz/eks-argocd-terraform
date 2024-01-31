terraform {
  required_version = ">=0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.4.1"
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
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = "${base64decode(yamldecode(module.eks.cluster_certificate_authority_data))}"
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

provider "kubectl" {
  alias = "kubectl-provider"
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = "${base64decode(yamldecode(module.eks.cluster_certificate_authority_data))}"
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command = "aws"
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

provider "helm" {
  #alias = "helm-provider"
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = "${base64decode(yamldecode(module.eks.cluster_certificate_authority_data))}"
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    }
  }
}
