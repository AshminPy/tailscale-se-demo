# Create the empty secret
resource "aws_secretsmanager_secret" "tailscale_auth" {
  name        = "${var.prefix}-tailscale-auth"
  description = "Holds the Tailscale auth key for subnet router"
}

# Important Noe:  DO NOT store value in Terraform
resource "aws_secretsmanager_secret_version" "tailscale_auth_version" {
  secret_id     = aws_secretsmanager_secret.tailscale_auth.id
  secret_string = var.tailscale_auth_key != "" ? var.tailscale_auth_key : null

  lifecycle {
    ignore_changes = [secret_string]
  }
}
