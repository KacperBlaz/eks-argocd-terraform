variable "environment" {
  type = string
}

variable "sa-role-arn" {
  type = string
}

variable "cluster_name" {
  type = string
}

#variable "host" {}
#
#variable "cluster_certificate" {}

variable "eks_serviceaccount_name" {
  type = string
}

variable "serviceaccount_namespace" {
  type    = string
}