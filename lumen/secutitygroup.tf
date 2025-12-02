##Creating main security group for the vpc
resource "aws_security_group" "sumens-dev-vpc-sg" {
  name        = "sumens-dev-vpc-sg"
  description = "allows ssh, http & https inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.sumens-vpc.id

  dynamic "ingress" {
    for_each = var.sumens-ingress-rule

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_block
    }
  }

  dynamic "egress" {
    for_each = var.sumens-egress-rule

    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_block
    }
  }

  tags = {
    Name = "sumens-dev-sg"
  }
}
