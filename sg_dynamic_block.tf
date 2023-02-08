#Using Dynamic Blocks For Security Group
# You can dynamically construct repeatable nested blocks like settings using a 
# special dynamic block type, which is supported inside resource, data, provider, 
# and provisioner blocks:

#Pass a list value to "toset" to convert it to a set, 
#which will remove any duplicate elements and discard the ordering of the elements.

#distinct takes a list and returns a new list with any duplicate elements removed.

locals {
  ingress = toset([555, 6666, 7777, 80, 443, 22, 3389, 3306, 1433])
  egress  = toset([80, 443, 8080, 9090])
  #egress = var.egress
}

resource "aws_security_group" "sg_dynamic" {
  name        = "sg_dynamic"
  description = "Allow all inbound traffic using Dynamic Blocks"
  vpc_id      = aws_vpc.default.id
  tags = {
    Name = "${var.vpc_name}_Dynamic_Sg"
  }
  dynamic "ingress" {
    for_each = local.ingress
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = local.egress
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}