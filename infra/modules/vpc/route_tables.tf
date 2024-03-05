locals {
   private_public_mapping = zipmap(keys(var.private_subnets_cidr_blocks), keys(var.public_subnets_cidr_blocks))
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.this.id
  depends_on = [aws_internet_gateway.this]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "eks-public-route-table-${var.environment}"
    Environment = var.environment
  }
}


resource "aws_route_table_association" "public_route_table" {
  for_each = var.public_subnets_cidr_blocks
  depends_on = [aws_route_table.public_route]
  subnet_id = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.public_route.id
}


resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.this.id
  for_each = aws_nat_gateway.this
  depends_on = [aws_nat_gateway.this]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.this[each.key].id
  }

  tags = {
    Name = "eks-private-route-table-${var.environment}"
    Environment = var.environment
  }
}


resource "aws_route_table_association" "private_route_table" {
  for_each = aws_subnet.private_subnet
  depends_on = [aws_subnet.private_subnet]
  route_table_id = aws_route_table.private_route[local.private_public_mapping[each.key]].id

  subnet_id = each.value.id
}
