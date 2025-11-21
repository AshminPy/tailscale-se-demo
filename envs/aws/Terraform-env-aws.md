## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_tailscale_router"></a> [aws\_tailscale\_router](#module\_aws\_tailscale\_router) | ../../modules/aws-tailscale-router | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | n/a | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | n/a | yes |
| <a name="input_az"></a> [az](#input\_az) | n/a | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_private_subnet_cidr"></a> [private\_subnet\_cidr](#input\_private\_subnet\_cidr) | n/a | `string` | n/a | yes |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | n/a | `string` | n/a | yes |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | SSH key name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |
| <a name="input_tailscale_auth_key"></a> [tailscale\_auth\_key](#input\_tailscale\_auth\_key) | n/a | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_igw_id"></a> [igw\_id](#output\_igw\_id) | Internet Gateway ID for the public subnet |
| <a name="output_nat_eip"></a> [nat\_eip](#output\_nat\_eip) | Elastic IP allocated to the NAT Gateway |
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | NAT Gateway ID for the private subnet |
| <a name="output_private_instance_id"></a> [private\_instance\_id](#output\_private\_instance\_id) | n/a |
| <a name="output_private_instance_private_ip"></a> [private\_instance\_private\_ip](#output\_private\_instance\_private\_ip) | n/a |
| <a name="output_private_route_table_id"></a> [private\_route\_table\_id](#output\_private\_route\_table\_id) | Private route table ID |
| <a name="output_private_sg_id"></a> [private\_sg\_id](#output\_private\_sg\_id) | Security group ID for the private EC2 instance |
| <a name="output_private_subnet_id"></a> [private\_subnet\_id](#output\_private\_subnet\_id) | The private subnet ID |
| <a name="output_public_route_table_id"></a> [public\_route\_table\_id](#output\_public\_route\_table\_id) | Public route table ID |
| <a name="output_public_subnet_id"></a> [public\_subnet\_id](#output\_public\_subnet\_id) | The public subnet ID |
| <a name="output_router_eip"></a> [router\_eip](#output\_router\_eip) | n/a |
| <a name="output_router_instance_id"></a> [router\_instance\_id](#output\_router\_instance\_id) | n/a |
| <a name="output_router_private_ip"></a> [router\_private\_ip](#output\_router\_private\_ip) | n/a |
| <a name="output_router_sg_id"></a> [router\_sg\_id](#output\_router\_sg\_id) | Security group ID for the Tailscale router |
| <a name="output_tailscale_secret_arn"></a> [tailscale\_secret\_arn](#output\_tailscale\_secret\_arn) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the AWS demo VPC |
