#data "terraform_remote_state" "eks" {
#  backend = "s3"
#
#  config = {
#    bucket = "argocd-eks-infra"
#    region = "us-east-1"
#    key = "argocd-eks-infra.json"
#}
#}