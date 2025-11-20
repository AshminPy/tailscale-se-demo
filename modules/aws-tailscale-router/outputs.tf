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

# Internet Gateway ID
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
