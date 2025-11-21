resource "aws_instance" "private" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.aws_network.private_subnets[0]
  key_name      = var.ssh_key_name

  vpc_security_group_ids = [
    aws_security_group.private_sg.id
  ]

  # No public IP
  associate_public_ip_address = false

  tags = merge(
    var.tags,
    {
      Name = "${var.prefix}-private-ec2"
    }
  )
}
