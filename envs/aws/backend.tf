terraform {
  backend "s3" {
    bucket         = "tailscale-demo-tfstate"
    key            = "aws/terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "tailscale-demo-lock"
    encrypt        = true
  }
}
