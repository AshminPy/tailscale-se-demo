# AWS Network Variables (Single AZ)

variable "prefix" {
  type        = string
  description = "Base name prefix for AWS resources"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "az" {
  type        = string
  description = "Single availability zone for demo"
}

variable "public_subnet_cidr" {
  type        = string
  description = "Public subnet CIDR"
}

variable "private_subnet_cidr" {
  type        = string
  description = "Private subnet CIDR"
}

variable "tags" {
  type        = map(string)
  description = "Common tags for all resources"
  default     = {}
}

# variable "ami_id" {
#   description = "AMI ID for EC2 instances"
#   type        = string
# }

# variable "instance_type" {
#   description = "EC2 instance type"
#   type        = string
#   default     = "t2.micro"
# }

# variable "ssh_key_name" {
#   description = "SSH key name"
#   type        = string
# }

variable "tailscale_auth_key" {
  description = "Tailscale auth key used for router setup"
  type        = string
  sensitive   = true
}
