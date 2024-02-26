variable "aws_region" {
  type = string
}

variable "environment" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}

variable "public_subnets_ids" {}

variable "private_subnets_ids" {}

variable "desired_size" {
  type = string
}

variable "min_size" {
  type = string
}

variable "max_size" {
  type = string
}

variable "capacity_type" {
  type = string
}

variable "instance_types" {
  type = string
}

variable "max_unavailable" {
  type = string
}

variable "account_id" {
  type = string
}

variable "eks_serviceaccount_name" {
  type = string
}

variable "serviceaccount_namespace" {
  type = string
}

### KARPETNER ###

variable "karpenter_serviceaccount_namespace" {
  type = string
}

variable "karpetner_eks_serviceaccount_name" {
  type = string
}

variable "kubeconfig_filepath" {
  type = string
}