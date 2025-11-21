# Router EC2 instance
resource "aws_instance" "router" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.aws_network.public_subnets[0]
  key_name      = var.ssh_key_name

  vpc_security_group_ids = [
    aws_security_group.router_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.router_profile.name

  user_data = templatefile("${path.module}/router_user_data.sh.tpl", {
    tailscale_secret_arn = aws_secretsmanager_secret.tailscale_auth.arn
    region               = var.aws_region
    private_cidr         = var.private_subnet_cidr
    hostname             = "${var.prefix}-router"
  })

  user_data_replace_on_change = true

  tags = merge(
    var.tags,
    {
      Name = "${var.prefix}-router-ec2"
    }
  )

  depends_on = [
    aws_eip.router_eip
  ]
}
