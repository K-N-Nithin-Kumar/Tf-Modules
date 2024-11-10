#This Terraform Code Deploys Basic VPC Infra.
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "knnithinkumar-terra"
    key    = "dev.tfstate"
    region = "us-east-1"
  }
}
# Consuming the modules 

# Consuming VPC module for DEV environment

module "dev_vpc_1" {
  source              = "../modules/network"
  vpc_name            = "dev_vpc_01"
  vpc_cidr            = "172.18.0.0/16"
  environment         = "dev"
  public_cird_block   = ["172.18.1.0/24", "172.18.2.0/24"]
  private_cird_block  = ["172.18.10.0/24", "172.18.20.0/24"]
  azs                 = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnet_name  = "App-public"
  private_subnet_name = "Db-private"
}

# Consuming Security group module
module "dev_sg_1" {
  source        = "../modules/sg"
  vpc_name      = module.dev_vpc_1.vpc_name
  vpc_id        = module.dev_vpc_1.vpc_id
  service_ports = ["80", "8080", "443", "22", "3306"]
  environment   = module.dev_vpc_1.environment
}

# Consumming Compute module
module "dev_ec2_1" {
  source      = "../modules/compute"
  public_ec2_name = "App-server-pub"
  environment = module.dev_vpc_1.environment
  amis = {
    "us-east-1" = "ami-0866a3c8686eaeeba"
    "us-east-2" = "ami-0ea3c35c5c3284d82"
  }
  aws_region      = var.aws_region
  key_name        = "smart-remedy"
  public_subnets  = module.dev_vpc_1.public-subnet
  private_subnets = ""
  sg_id           = module.dev_sg_1.sg_id
}