module "aws_tailscale_router" {
  source = "../../modules/aws-tailscale-router"

  prefix              = "ts-aws-demo"
  vpc_cidr            = "10.10.0.0/16"
  az                  = "ca-central-1a"
  public_subnet_cidr  = "10.10.1.0/24"
  private_subnet_cidr = "10.10.2.0/24"

  tags = {
    project = "tailscale-multicloud-demo"
    env     = "demo"
  }
}
