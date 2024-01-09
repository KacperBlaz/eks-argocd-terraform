module "main" {
  source = "../../modules/main"
  environment = var.environment
  availability_zone = var.availability_zone
  eks_cluster_name = var.eks_cluster_name
  vpc_cidr_block = var.vpc_cidr_block
  public_subnets_cidr_blocks = var.public_subnets_cidr_blocks
  private_subnets_cidr_blocks = var.private_subnets_cidr_blocks
  aws_region = var.aws_region
  min_size = var.min_size
  max_size = var.max_size
  desired_size = var.desired_size
  capacity_type = var.capacity_type
  instance_types = var.instance_types
  max_unavailable = var.max_unavailable
  argocd_namespace = var.argocd_namespace
}