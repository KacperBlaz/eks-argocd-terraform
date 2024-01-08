locals {
  eks_cluster_name = "${var.eks_cluster_name}-${var.environment}"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Environment = var.environment
    Name = var.tags["VPC_NAME"]
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

#resource "aws_eip" "elastic-ip" {
#
#}
#
#resource "aws_nat_gateway" "eks_nat" {
#  subnet_id =
#}