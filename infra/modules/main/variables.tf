### GENERAL ###

variable "aws_region" {
  type = string
}

variable "availability_zone" {
}

variable "cert-manager-namespace" {
  type = string
}

### KARPETNER ###

variable "karpetner_eks_serviceaccount_name" {
  type = string
}

variable "karpenter_serviceaccount_namespace" {
  type = string
}
#variable "loadbalancer_controller_role_arn" {
#  type = string
#}
#variable "kubectl-provider" {
#  type = string
#}

variable "environment" {
  type = string
}

### NETWORKING MODULE ###

variable "vpc_cidr_block" {
  type = string
}

variable "public_subnets_cidr_blocks" {
}

variable "private_subnets_cidr_blocks" {
}

### EKS MODULE ###

variable "eks_cluster_name" {
  type = string
}

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

### EKS CONFIGURATION ###

variable "eks_serviceaccount_name" {
  type = string
}

variable "serviceaccount_namespace" {
  type = string
}

### ARGOCD ###

variable "argocd_namespace" {
  type = string
}

variable "account_id" {}

variable "argo_repo_url" {
  type        = string
}

variable "argocd_helm_chart_version" {
  description = "argocd helm chart version to use"
  type        = string
  default     = ""
}

#variable "argocd_server_host" {
#  description = "Hostname for argocd (will be utilised in ingress if enabled)"
#  type        = string
#  default     = "argocd.calvineotieno.com"
#}

variable "argocd_ingress_enabled" {
  description = "Enable/disable argocd ingress"
  type        = bool
}


variable "argocd_name" {
  default = "argocd-eks"
}

variable "argocd_server_host" {}

