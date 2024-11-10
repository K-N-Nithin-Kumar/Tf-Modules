# Public RT
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = merge(
    local.common_tags,
    {
      Name        = "${var.vpc_name}-public-route-table"
      environment = "${var.environment}"
    }
  )
}

# Private RT
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.default.id

  tags = merge(
    local.common_tags,
    {
      Name        = "${var.vpc_name}-private-route-table"
      environment = "${var.environment}"
    }
  )
}

# RT association

#Associating private subnets to private route table
resource "aws_route_table_association" "public-subnet-association" {
  count          = length(var.public_cird_block)
  subnet_id      = element(aws_subnet.public-subnet.*.id, count.index)
  route_table_id = aws_route_table.public-route-table.id
}

#Associating private subnets to private route table
resource "aws_route_table_association" "private-subnet-association" {
  count          = length(var.private_cird_block)
  subnet_id      = element(aws_subnet.private-subnet.*.id, count.index)
  route_table_id = aws_route_table.private-route-table.id
}

