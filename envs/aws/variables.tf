
variable "prefix" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "az" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "ami_id" {
  type = string
}

variable "tailscale_auth_key" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "ssh_key_name" {
  description = "SSH key name"
  type        = string
}

variable "my_home_ip" {
  description = "Your public IP for SSH access"
  type        = string
}
