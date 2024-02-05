module "vpc" {
  source = "../networking"
  availability_zone = var.availability_zone
  eks_cluster_name = var.eks_cluster_name
  environment = var.environment
  private_subnets_cidr_blocks = var.private_subnets_cidr_blocks
  public_subnets_cidr_blocks = var.public_subnets_cidr_blocks
  vpc_cidr_block = var.vpc_cidr_block
  cluster_name = var.eks_cluster_name
}

module "eks" {
  source = "../eks"
  depends_on = [module.vpc]
  environment = var.environment
  private_subnets_ids = module.vpc.private_subnets_ids
  public_subnets_ids = module.vpc.public_subnets_ids
  desired_size = var.desired_size
  max_size     = var.max_size
  min_size     = var.min_size
  eks_cluster_name = var.eks_cluster_name
  capacity_type = var.capacity_type
  instance_types = var.instance_types
  max_unavailable = var.max_unavailable
  aws_region = var.aws_region
  account_id = var.account_id
  eks_serviceaccount_name = var.eks_serviceaccount_name
  serviceaccount_namespace = var.serviceaccount_namespace
  karpetner_eks_serviceaccount_name = var.karpetner_eks_serviceaccount_name
  karpenter_serviceaccount_namespace = var.karpenter_serviceaccount_namespace
}

#module "eks-irsa" {
#  source  = "nalbam/eks-irsa/aws"
#  version = "0.13.2"
#  depends_on = [module.eks]
#  name = "apps_role_${var.environment}"
#  region = var.aws_region
#  cluster_name = module.eks.cluster_name
#  cluster_names = [
#    module.eks.cluster_name
#  ]
#  kube_namespace      = var.serviceaccount_namespace
#  kube_serviceaccount = "${var.eks_serviceaccount_name}-${var.environment}"
#
#  policy_arns = [
#    aws_iam_policy.iamSecretPolicy.arn
#  ]
#}

module "iam" {
  source = "../iam"
  environment = var.environment
}

module "k8s" {
  providers = {
    kubectl = kubectl.kubectl-provider
  }
  depends_on = [module.eks, module.karpenter]
  source = "../k8s"
  environment = var.environment
  sa-role-arn = module.eks.eks_cluster_autoscaler_arn
  eks_serviceaccount_name = var.eks_serviceaccount_name
  serviceaccount_namespace = var.serviceaccount_namespace
  cluster_name = module.eks.cluster_name
}

module "karpenter" {
  source = "../karpenter"
  depends_on = [module.eks]
  environment = var.environment
  loadbalancer_controller_role_arn = module.eks.eks_cluster_autoscaler_arn
  cert-manager-namespace = var.cert-manager-namespace
  cluster_name = module.eks.cluster_name
  serviceaccount_name = var.eks_serviceaccount_name
  cluster_endpoint = module.eks.cluster_endpoint
  karpetner_eks_serviceaccount_name = var.karpetner_eks_serviceaccount_name
  karpenter_serviceaccount_namespace = var.karpenter_serviceaccount_namespace
  karpetner_service_account_arn = module.eks.karpenter_role_arn
  instance_profile_name = module.eks.karpetner_instance_profile_name
}

module "argocd" {
  source = "../argocd"
  depends_on = [module.eks,module.karpenter,module.k8s]
  environment = var.environment
  argo_repo_url = var.argo_repo_url
  argocd_helm_chart_version = var.argocd_helm_chart_version
  argocd_ingress_enabled = var.argocd_ingress_enabled
  argocd_name = var.argocd_name
  argocd_namespace = var.argocd_namespace
  argocd_server_host = var.argocd_server_host
}

#module "application" {
#  providers = {
#    kubectl = kubectl.kubectl-provider
#  }
#  depends_on = [module.argocd]
#  source = "../argo_applications"
#}
