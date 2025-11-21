# Allocate an Elastic IP for the router
resource "aws_eip" "router_eip" {
  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name = "${var.prefix}-router-eip"
    }
  )
}

# Attach the Elastic IP
resource "aws_eip_association" "router_eip_assoc" {
  instance_id   = aws_instance.router.id
  allocation_id = aws_eip.router_eip.id

  depends_on = [
    aws_instance.router
  ]
}
