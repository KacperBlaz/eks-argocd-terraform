module "vpc" {
  source = "../networking"
  availability_zone = var.availability_zone
  eks_cluster_name = var.eks_cluster_name
  environment = var.environment
  private_subnets_cidr_blocks = var.private_subnets_cidr_blocks
  public_subnets_cidr_blocks = var.public_subnets_cidr_blocks
  vpc_cidr_block = var.vpc_cidr_block
}