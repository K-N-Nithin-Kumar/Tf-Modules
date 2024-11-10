resource "aws_subnet" "public-subnet" {
  #count             = 3 #012
  count             = length(var.public_cird_block)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.public_cird_block, count.index + 1)
  availability_zone = element(var.azs, count.index)

  tags = merge(
    local.common_tags,
    {
      Name        = "${var.public_subnet_name}-${count.index + 1}"
      environment = "${var.environment}"
    }
  )
}