prefix              = "ts-aws-demo"
vpc_cidr            = "10.10.0.0/16"
az                  = "ca-central-1a"
public_subnet_cidr  = "10.10.1.0/24"
private_subnet_cidr = "10.10.2.0/24"

tags = {
  project = "tailscale-multicloud-demo"
  env     = "demo"
}

ami_id             = "ami-0abac8735a38475db"
ssh_key_name       = "ts-aws-demo-key"
tailscale_auth_key = "dummyauthkey12#"
aws_region         = "ca-central-1"
my_home_ip         = "67.70.199.84/32"
