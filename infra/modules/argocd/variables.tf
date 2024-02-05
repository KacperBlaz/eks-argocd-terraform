variable "environment" {
  type = string
}

variable "argo_repo_url" {
  type        = string
}

variable "argocd_namespace" {
  description = "Namespace to release argocd into"
  type        = string
  default     = "argocd"
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
  default     = true
}


variable "argocd_name" {
  default = "argocd-eks"
}

variable "argocd_server_host" {}

