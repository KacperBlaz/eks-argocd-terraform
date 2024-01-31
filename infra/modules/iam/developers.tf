data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks-developers-role" {
  name               = "eks-${var.environment}-developers-role"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}

resource "aws_iam_policy" "eks-developers-policy" {
  name = "eks-${var.environment}-developers-policy"

  policy = file("policy/developers-policy.json")
}

resource "aws_iam_role_policy_attachment" "eks_developers_role_attach" {
  role       = aws_iam_role.eks-developers-role.name
  policy_arn = aws_iam_policy.eks-developers-policy.arn
}

