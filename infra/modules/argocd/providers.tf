#provider "aws" {
#  region = var.aws_region
#  default_tags {
#    tags = {
#      Project   = "argocd-demo"
#      ManagedBy = "Terraform"
#    }
#  }
#}

## get EKS authentication for being able to manage k8s objects from terraform
#provider "kubernetes" {
#  host                   = var.kubernetes_host
#  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
#  exec {
#    api_version = "client.authentication.k8s.io/v1beta1"
#    args        = ["eks", "get-token", "--cluster-name", "${var.cluster_name}"]
#    command     = "aws"
#  }
#}
