locals {
  eks_cluster_name = "${var.eks_cluster_name}-${var.environment}"
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Environment = "vpc-${var.environment}"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}
