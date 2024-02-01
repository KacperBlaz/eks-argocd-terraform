
resource "helm_release" "karpenter" {
  namespace = var.karpenter_serviceaccount_namespace
  create_namespace = true

  name       = "karpenter"
  repository = "https://charts.karpenter.sh"
  chart      = "karpenter"
  version    = "v0.13.1"

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.karpetner_service_account_arn
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "clusterEndpoint"
    value = var.cluster_endpoint
  }
  set {
    name  = "aws.defaultInstanceProfile"
    value = var.instance_profile_name
  }
}