resource "aws_iam_policy" "iamSecretPolicy" {
  name        = "${var.environment}_secretPolicy"
  path        = "/"
  description = "Allow access to ${var.environment} secrets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:secretsmanager:${var.aws_region}:${var.account_id}:secret:${var.environment}/*"
        ]
      },
    ]
  })
}