module "main" {
  source = "../../modules/main"
  environment = var.environment
  availability_zone = var.availability_zone
  eks_cluster_name = var.eks_cluster_name
  vpc_cidr_block = var.vpc_cidr_block
  public_subnets_cidr_blocks = var.public_subnets_cidr_blocks
  private_subnets_cidr_blocks = var.private_subnets_cidr_blocks
  region = var.region
}