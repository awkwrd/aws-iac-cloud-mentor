locals {
  tags = {
    Project = var.project
  }
}

resource "aws_iam_group" "iam_group" {
  name = "${var.project}-iam-group"
}

resource "aws_iam_policy" "iam_policy" {
  name        = "${var.project}-iam-policy"
  description = "Policy to grant write permissions to the S3 bucket"

  policy = templatefile("${path.module}/policy.json", {
    s3_bucket_name = var.s3_bucket_name
  })

  tags = local.tags
}

resource "aws_iam_role" "iam_role" {
  name = "${var.project}-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.project}-iam-instance-profile"
  role = aws_iam_role.iam_role.name

  tags = local.tags
}