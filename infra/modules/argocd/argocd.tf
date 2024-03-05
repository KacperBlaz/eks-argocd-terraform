resource "helm_release" "argocd" {
  name             = "argocd-eks-${var.environment}"
  repository       = var.argo_repo_url
  chart            = "argo-cd"
  namespace        = var.argocd_namespace
  create_namespace = true
  version          = var.argocd_helm_chart_version == "" ? null : var.argocd_helm_chart_version

  values = [
    templatefile(
      "../../modules/argocd/templates/values.yaml.tpl",
      {
        "argocd_ingress_enabled"          = var.argocd_ingress_enabled
        "argocd_ingress_class"            = "alb"
        "argocd_server_host"              = var.argocd_server_host
        "argocd_load_balancer_name"       = "argocd-${var.argocd_name}-alb-ingress"
        "argocd_ingress_tls_acme_enabled" = true
      }
    )
  ]

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
    type  = "string"
  }
}

data "kubernetes_service" "argo_loadbalancer" {
  depends_on = [
    helm_release.argocd
  ]
  metadata {
    name      = "argocd-eks-${var.environment}-server"
    namespace = var.argocd_namespace
  }
}
