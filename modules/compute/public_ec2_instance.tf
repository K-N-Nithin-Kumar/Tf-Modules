resource "aws_instance" "public-server" {
  # count = length(var.public_cird_block)
  count                       = var.environment == "dev" ? 1 : 0
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = element(var.public_subnets, count.index + 1)
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = true
  tags = merge(
    local.common_tags,
    {
      Name        = "${var.public_ec2_name}-${count.index + 1}"
      environment = "${var.environment}"
  })
}