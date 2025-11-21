output "vpc_id" {
  description = "The ID of the AWS demo VPC"
  value       = module.aws_tailscale_router.vpc_id
}

output "public_subnet_id" {
  description = "The public subnet ID"
  value       = module.aws_tailscale_router.public_subnet_id
}

output "private_subnet_id" {
  description = "The private subnet ID"
  value       = module.aws_tailscale_router.private_subnet_id
}

output "igw_id" {
  description = "Internet Gateway ID for the public subnet"
  value       = module.aws_tailscale_router.igw_id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID for the private subnet"
  value       = module.aws_tailscale_router.nat_gateway_id
}

output "nat_eip" {
  description = "Elastic IP allocated to the NAT Gateway"
  value       = module.aws_tailscale_router.nat_eip
}

output "public_route_table_id" {
  description = "Public route table ID"
  value       = module.aws_tailscale_router.public_route_table_id
}

output "private_route_table_id" {
  description = "Private route table ID"
  value       = module.aws_tailscale_router.private_route_table_id
}

output "router_sg_id" {
  description = "Security group ID for the Tailscale router"
  value       = module.aws_tailscale_router.router_sg_id
}

output "private_sg_id" {
  description = "Security group ID for the private EC2 instance"
  value       = module.aws_tailscale_router.private_sg_id
}

output "router_instance_id" {
  value = module.aws_tailscale_router.router_instance_id
}

output "router_private_ip" {
  value = module.aws_tailscale_router.router_private_ip
}

output "tailscale_secret_arn" {
  value = module.aws_tailscale_router.tailscale_secret_arn
}

output "router_eip" {
  value = module.aws_tailscale_router.router_eip
}
