resource "aws_subnet" "private-subnet" {
  #   count             = 3 #012
  count             = length(var.private_cird_block)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.private_cird_block, count.index)
  availability_zone = element(var.azs, count.index)

  tags = merge(
    local.common_tags,
    {
      Name        = "${var.private_subnet_name}-${count.index + 1}"
      environment = "${var.environment}"
    }
  )
}