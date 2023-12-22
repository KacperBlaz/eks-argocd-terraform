variable "availability_zone" {}

variable "vpc_cidr_block" {
  type = string
}

variable "public_subnets_cidr_blocks" {}

variable "private_subnets_cidr_blocks" {}

variable "environment" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}

variable "tags" {
  type = map(any)

  default = {
    VPC_NAME = "vpc_eks"
  }
}