module "aws_tailscale_router" {
  source = "../../modules/aws-tailscale-router"

  prefix              = var.prefix
  vpc_cidr            = var.vpc_cidr
  az                  = var.az
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr

  tags = var.tags

  ami_id             = var.ami_id
  tailscale_auth_key = var.tailscale_auth_key
  aws_region         = var.aws_region
  ssh_key_name       = var.ssh_key_name

  my_home_ip = var.my_home_ip


}
