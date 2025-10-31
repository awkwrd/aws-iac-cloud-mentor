resource "aws_iam_policy" "cmtr_fvj3554p_iam_policy" {
  name        = "cmtr-fvj3554p-iam-policy"
  description = "Custom role with limited permissions"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ec2:*",
          "s3:*"
        ],
        Resource = "*"
      }
    ]
  })
}