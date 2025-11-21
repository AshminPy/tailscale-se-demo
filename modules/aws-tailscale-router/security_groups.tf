# SECURITY GROUPS FOR TAILSCALE DEMO

# Router SG (EC2 in Public Subnet)
resource "aws_security_group" "router_sg" {
  name        = "${var.prefix}-router-sg"
  description = "Security group for the Tailscale subnet router"
  vpc_id      = module.aws_network.vpc_id

  # Outbound allowed (needed for Tailscale)
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      name = "${var.prefix}-router-sg"
    }
  )
}

# Allow SSH only from Tailscale IP ranges (updated later)
resource "aws_security_group_rule" "router_allow_ssh_from_tailnet" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.router_sg.id
  cidr_blocks       = ["100.64.0.0/10"]
  description       = "Allow SSH from Tailscale"
}

# Private Instance SG (EC2 in Private Subnet)
resource "aws_security_group" "private_sg" {
  name        = "${var.prefix}-private-sg"
  description = "Security group for private test instance"
  vpc_id      = module.aws_network.vpc_id

  # Outbound allowed
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      name = "${var.prefix}-private-sg"
    }
  )
}

# Allow SSH from router SG only
resource "aws_security_group_rule" "allow_ssh_from_router" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.private_sg.id
  source_security_group_id = aws_security_group.router_sg.id
  description              = "Allow SSH from router instance"
}

# Allow SSH from your home IP only
resource "aws_security_group_rule" "allow_ssh_home" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.my_home_ip]
  security_group_id = aws_security_group.router_sg.id
}
