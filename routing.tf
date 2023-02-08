resource "aws_route_table" "terraform-public-rt" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
  tags = {
    Name = "${var.vpc_name}-publicRT"
  }
}

resource "aws_route_table" "terraform-private-rt" {
  vpc_id = aws_vpc.default.id
  #   route {
  #     cidr_block = "0.0.0.0/0"
  #     gateway_id = aws_nat_gateway.nat-gw.id
  #   }
  tags = {
    Name = "${var.vpc_name}-privateRT"
  }
}


resource "aws_route_table_association" "terraform-public" {
  #count             = 3
  count          = length(var.public_cidrs)
  subnet_id      = element(aws_subnet.public-subnets.*.id, count.index)
  route_table_id = aws_route_table.terraform-public-rt.id
}

resource "aws_route_table_association" "terraform-private" {
  #count             = 3
  count          = length(var.public_cidrs)
  subnet_id      = element(aws_subnet.private-subnets.*.id, count.index)
  route_table_id = aws_route_table.terraform-private-rt.id
}

