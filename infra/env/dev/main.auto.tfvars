vpc_cidr_block           = "10.10.0.0/16"
environment              = "dev"
availability_zone        = "us-east-1a"
eks_cluster_name         = "EKS-cluster"
min_size                 = "1"
max_size                 = "5"
desired_size             = "3"
capacity_type            = "ON_DEMAND"
instance_types           = "t3.small"
max_unavailable          = "1"
aws_region               = "us-east-1"
argocd_namespace         = "argocd"
account_id               = "410040632229"
eks_serviceaccount_name  = "serviceaccount-eks"
serviceaccount_namespace = "kube-system"
cert-manager-namespace   = "default"
karpenter_serviceaccount_namespace = "karpenter"
karpetner_eks_serviceaccount_name = "karpenter"