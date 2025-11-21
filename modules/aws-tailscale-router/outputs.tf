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

# Internet Gateway ID.
output "igw_id" {
  description = "Internet Gateway for public subnet"
  value       = module.aws_network.igw_id
}

# NAT Gateway ID
output "nat_gateway_id" {
  description = "NAT Gateway for private subnet"
  value       = module.aws_network.natgw_ids[0]
}

# EIP for NAT Gateway
output "nat_eip" {
  description = "Public Elastic IP for the NAT Gateway"
  value       = module.aws_network.nat_public_ips[0]
}

# Public route table
output "public_route_table_id" {
  description = "Public route table ID"
  value       = module.aws_network.public_route_table_ids[0]
}

# Private route table
output "private_route_table_id" {
  description = "Private route table ID"
  value       = module.aws_network.private_route_table_ids[0]
}

output "router_sg_id" {
  description = "Security group ID for the Tailscale router"
  value       = aws_security_group.router_sg.id
}

output "private_sg_id" {
  description = "Security group ID for the private EC2 instance"
  value       = aws_security_group.private_sg.id
}

output "router_instance_id" {
  description = "The EC2 instance ID for the Tailscale router"
  value       = aws_instance.router.id
}

output "router_private_ip" {
  description = "Private IP of the router EC2 instance"
  value       = aws_instance.router.private_ip
}

output "tailscale_secret_arn" {
  description = "ARN of the Tailscale auth key secret"
  value       = aws_secretsmanager_secret.tailscale_auth.arn
}

output "router_eip" {
  description = "Elastic IP assigned to the Tailscale router"
  value       = aws_eip.router_eip.public_ip
}
