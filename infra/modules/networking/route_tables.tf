resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "eks-public-route-table-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_main_route_table_association" "main_route_table" {
  route_table_id = aws_route_table.main.id
  vpc_id         = aws_vpc.main.id
}

