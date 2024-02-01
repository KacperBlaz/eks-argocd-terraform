variable "environment" {
  type = string
}

variable "loadbalancer_controller_role_arn" {
  type = string
}

variable "cert-manager-namespace" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "serviceaccount_name" {
  type = string
}

variable "karpetner_eks_serviceaccount_name" {
  type = string
}

variable "karpenter_serviceaccount_namespace" {
  type = string
}

variable "karpetner_service_account_arn" {
  type = string
}

variable "instance_profile_name" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}