# IAM role for router ec2

resource "aws_iam_role" "router_role" {
  name = "${var.prefix}-router-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# IAM policy : to read secret
resource "aws_iam_policy" "router_secret_policy" {
  name        = "${var.prefix}-router-secret-read"
  description = "Allows router EC2 to read Tailscale auth key secret"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["secretsmanager:GetSecretValue"]
        Resource = aws_secretsmanager_secret.tailscale_auth.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secret_policy" {
  role       = aws_iam_role.router_role.name
  policy_arn = aws_iam_policy.router_secret_policy.arn
}

resource "aws_iam_instance_profile" "router_profile" {
  name = "${var.prefix}-router-profile"
  role = aws_iam_role.router_role.name
}
