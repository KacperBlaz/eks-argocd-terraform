### AUTOSCALER-OIDC ###

data "aws_iam_policy_document" "eks_cluster_autoscaler_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.opeid_provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:${var.serviceaccount_namespace}:${var.eks_serviceaccount_name}"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.opeid_provider.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks_cluster_autoscaler" {
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_autoscaler_assume_role_policy.json
  name               = "oidc"
}

resource "aws_iam_policy" "eks_cluster_autoscaler" {
  name = "eks-cluster-autoscaler"

  policy = file("./policy/loadbalancer-controller.json")
}

resource "aws_iam_role_policy_attachment" "eks_cluster_autoscaler_attach" {
  role       = aws_iam_role.eks_cluster_autoscaler.name
  policy_arn = aws_iam_policy.eks_cluster_autoscaler.arn
}

output "eks_cluster_autoscaler_arn" {
  value = aws_iam_role.eks_cluster_autoscaler.arn
}

### KARPETNER-OIDC ###

data "aws_iam_policy_document" "eks_karpetner_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.opeid_provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:${var.karpenter_serviceaccount_namespace}:${var.karpetner_eks_serviceaccount_name}"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.opeid_provider.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "karpetner-role" {
  assume_role_policy = data.aws_iam_policy_document.eks_karpetner_assume_role_policy.json
  name = "karpenter-controller-role"
}

resource "aws_iam_policy" "karpetner_policy" {
  policy = file("./policy/karpetner-controller-policy.json")
  name = "KarpetnerPolicy"
}

resource "aws_iam_role_policy_attachment" "LoadBalancer_Controller_Karpetner_Attach" {
  policy_arn = aws_iam_policy.karpetner_policy.arn
  role       = aws_iam_role.karpetner-role.name
}

resource "aws_iam_instance_profile" "Karpetner_Instance_Profile" {
  name = "KarpetnerNodeInstanceProfile"
  role = aws_iam_role.eks_node_group_role.name
}

output "karpenter_role_arn" {
  value = aws_iam_role.karpetner-role.arn
}

output "karpetner_instance_profile_name" {
  value = aws_iam_instance_profile.Karpetner_Instance_Profile.name
}