resource "aws_subnet" "public_subnet" {
  for_each = toset(var.public_subnets_cidr_blocks)
  vpc_id = aws_vpc.main.id
  availability_zone = var.availability_zone
  cidr_block = each.value
  map_public_ip_on_launch = true

  tags = {
    Name = "eks-public-subnet-${var.environment}-${index(var.public_subnets_cidr_blocks, each.value) + 1}"
    Environment = var.environment
  }
}

resource "aws_subnet" "private_subnet" {
  for_each = toset(var.private_subnets_cidr_blocks)
  vpc_id = aws_vpc.main.id
  availability_zone = var.availability_zone
  cidr_block = each.value
  map_public_ip_on_launch = false

  tags = {
    Name = "eks-private-subnet-${var.environment}-${index(var.private_subnets_cidr_blocks, each.value) + 1}"
    Environment = var.environment
  }
}

