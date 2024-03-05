resource "aws_eip" "this" {
  for_each = var.public_subnets_cidr_blocks
  vpc = true

  tags = {
    Name = "${var.environment}-${each.key}-EIP"
  }
}

resource "aws_nat_gateway" "this" {
  for_each = var.public_subnets_cidr_blocks
  subnet_id = aws_subnet.public_subnet[each.key].id
  allocation_id = aws_eip.this[each.key].id

  tags = {
    Name = "${var.environment}-${each.key}-NAT-GW"
  }

  depends_on = [aws_internet_gateway.this, aws_eip.this]
}

