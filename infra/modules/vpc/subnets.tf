resource "aws_subnet" "public_subnet" {
  for_each = var.public_subnets_cidr_blocks
  vpc_id = aws_vpc.this.id
  availability_zone = each.value.availability_zone
  cidr_block = each.value.cidr_block
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/role/elb" = 1
    Environment = var.environment
    "kubernetes.io/cluster/${var.eks_cluster_name}-${var.environment}"= "owned"
  }
}


resource "aws_subnet" "private_subnet" {
  for_each = var.private_subnets_cidr_blocks
  vpc_id = aws_vpc.this.id
  availability_zone = each.value.availability_zone
  cidr_block = each.value.cidr_block
  map_public_ip_on_launch = false

  tags = {
    "kubernetes.io/role/internal-elb" = 1
    Environment = var.environment
    "kubernetes.io/cluster/${var.eks_cluster_name}-${var.environment}" = "owned"
  }
}

