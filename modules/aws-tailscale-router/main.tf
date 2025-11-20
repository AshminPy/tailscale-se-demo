# AWS VPC (Single AZ, One Public + One Private Subnet)

module "aws_network" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.prefix}-vpc"

  # Single AZ VPC Layout
  cidr = var.vpc_cidr

  azs             = [var.az]
  public_subnets  = [var.public_subnet_cidr]
  private_subnets = [var.private_subnet_cidr]

  # NAT Gateway
  enable_nat_gateway = true
  single_nat_gateway = true

  # DNS
  enable_dns_support   = true
  enable_dns_hostnames = true

  # Tags
  tags = merge(
    var.tags,
    {
      module = "aws-tailscale-router"
    }
  )
}
