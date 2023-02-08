resource "aws_eip" "nat-eip" {
  tags = {
    Name = "NAT-EIP"
  }
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.public-subnets.0.id
  tags = {
    Name = "nat-gw"
  }
  depends_on = [aws_internet_gateway.default, aws_s3_bucket.devops30b]
}

