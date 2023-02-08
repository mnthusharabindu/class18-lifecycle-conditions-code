resource "aws_subnet" "public-subnets" {
  #count             = 3
  count             = length(var.public_cidrs)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.public_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.vpc_name}-publicsubnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private-subnets" {
  #count             = 3
  count             = length(var.public_cidrs)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.private_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.vpc_name}-privatesubnet-${count.index + 1}"
  }
}

