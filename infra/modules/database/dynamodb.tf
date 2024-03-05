#resource "aws_dynamodb_table" "frontend-database" {
#  name = "Users"
#  billing_mode = "PROVISIONED"
#  read_capacity = 10
#  write_capacity = 10
#  hash_key = "UserID"
#  range_key = "OrderID"
#
#  attribute {
#    name = "UserID"
#    type = "S"
#  }
#
#  attribute {
#    name = "OrderID"
#    type = "S"
#  }
#
#  attribute {
#    name = "Email"
#    type = "S"
#  }
#
#  tags = {
#    Name = "Database-frontend-${var.environment}"
#    Enviornment = "${var.environment}"
#  }
#}