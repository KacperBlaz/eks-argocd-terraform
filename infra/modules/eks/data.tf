data "aws_iam_role" "eks_cluster_autoscaler" {
  name = aws_iam_role.eks_cluster_autoscaler.name
}