resource "aws_eks_cluster" "argocd-cluster" {
  name     = "${var.eks_cluster_name}-${var.environment}"
  role_arn = aws_iam_role.eks_role.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids = concat(var.public_subnets_ids, var.private_subnets_ids)
#    security_group_ids {
#
#    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.attach_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.attach_AmazonEKSVPCResourceController
  ]


  tags = {
    Name        = "${var.eks_cluster_name}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_eks_node_group" "eks_cluster_node_group" {
  cluster_name  = aws_eks_cluster.argocd-cluster.name
  node_group_name = "eks_node_group-${var.environment}"
  node_role_arn = aws_iam_role.eks_node_group_role.arn
  subnet_ids = concat(var.public_subnets_ids)
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
  version = aws_eks_cluster.argocd-cluster.version
  capacity_type = var.capacity_type
  instance_types = [var.instance_types]
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = var.max_unavailable
  }

  tags = {
    Name = "EKS-Node-Group-${var.environment}"
    Environment = var.environment
    "karpenter.sh/discovery" = var.eks_cluster_name
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}

resource "null_resource" "load_eks_kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.aws_region} update-kubeconfig --name ${aws_eks_cluster.argocd-cluster.name}"
  }
}

data "local_file" "kubeconfig" {
  filename = "/root/.kube/config"
}


resource "aws_ssm_parameter" "eks-kubeconfig" {
  name = "/${var.environment}/eks/kubeconfig"
  type = "String"
  tier = "Advanced"
  value = data.local_file.kubeconfig.content
}
