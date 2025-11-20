# VPC ID
output "vpc_id" {
  description = "The ID of the demo VPC"
  value       = module.aws_network.vpc_id
}

# Public Subnet
output "public_subnet_id" {
  description = "The public subnet ID"
  value       = module.aws_network.public_subnets[0]
}

# Private Subnet
output "private_subnet_id" {
  description = "The private subnet ID"
  value       = module.aws_network.private_subnets[0]
}
