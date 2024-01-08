module "vpc" {
  source = "../networking"
  availability_zone = var.availability_zone
  eks_cluster_name = var.eks_cluster_name
  environment = var.environment
  private_subnets_cidr_blocks = var.private_subnets_cidr_blocks
  public_subnets_cidr_blocks = var.public_subnets_cidr_blocks
  vpc_cidr_block = var.vpc_cidr_block
}

module "eks" {
  source = "../eks"
  depends_on = [module.vpc]
  environment = var.environment
  private_subnets_ids = module.vpc.private_subnets_ids
  public_subnets_ids = module.vpc.public_subnets_ids
  desired_size = var.desired_size
  max_size     = var.max_size
  min_size     = var.min_size
  eks_cluster_name = var.eks_cluster_name
  capacity_type = var.capacity_type
  instance_types = var.instance_types
  max_unavailable = var.max_unavailable
  aws_region = var.aws_region
}

#module "argocd" {
#  source = "../argocd"
#  depends_on = [module.eks]
#  argocd_namespace = var.argocd_namespace
#  aws_region = var.aws_region
##  kubernetes_host = module.eks.cluster_endpoint
##  cluster_ca_certificate = module.eks.kubeconfig-cert
##  cluster_name  = module.eks.cluster_name
#}