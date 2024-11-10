resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = merge(
  local.common_tags,
    {
      Name        = "${var.vpc_name}"
      environment = "${var.environment}"
    }
  ) 
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "${var.vpc_name}-IGW"
  }
}

