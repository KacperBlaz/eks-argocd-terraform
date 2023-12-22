### GENERAL ###

variable "region" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "environment" {
  type = string
}

### NETWORKING MODULE ###

variable "vpc_cidr_block" {
  type = string
}

variable "public_subnets_cidr_blocks" {
  type = list(string)
}

variable "private_subnets_cidr_blocks" {
  type = list(string)
}

### EKS MODULE ###

variable "eks_cluster_name" {
  type = string
}
