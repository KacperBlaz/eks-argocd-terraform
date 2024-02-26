output "public_subnets_ids" {
  value = values(aws_subnet.public_subnet)[*].id
}

output "private_subnets_ids" {
  value = values(aws_subnet.private_subnet)[*].id
}