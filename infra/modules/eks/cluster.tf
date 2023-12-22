resource "aws_eks_cluster" "agrocd-cluster" {
  name     = "EKS-cluster-${var.environment}"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids {

    }
  }
}