data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.argocd-cluster.version}/amazon-linux-2/recommended/release_version"
}

output "cluster_endpoint" {
    value = aws_eks_cluster.argocd-cluster.endpoint
  }

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.argocd-cluster.certificate_authority[0].data
}

output "cluster_name" {
  value = aws_eks_cluster.argocd-cluster.name
}