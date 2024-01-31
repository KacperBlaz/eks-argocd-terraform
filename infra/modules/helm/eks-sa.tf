#resource "helm_release" "aws_loadbalancer_controller" {
#  name = "aws-loadbalancer-controller"
#  repository = "https://aws.github.io/eks-charts"
#  chart = "aws-load-balancer-controller"
#  namespace = "kube-system"
#
#  set {
#    name  = "clusterName"
#    value = var.cluster_name
#  }
##  set {
##    name  = "image.tag"
##    value = "v2.4.2"
##  }
#  set {
#    name  = "serviceAccount.name"
#    value = var.serviceaccount_name
#  }
#  set {
#    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#    value = var.loadbalancer_controller_role_arn
#  }
#}
#
##resource "helm_release" "cert_manager" {
##  name       = "cert-manager"
##  repository = "https://charts.jetstack.io"
##  chart      = "cert-manager"
##  version    = "v1.12.3"
##  namespace  = "kube-system"
##set {
##    name  = "installCRDs"
##    value = "true"
##  }
##}
