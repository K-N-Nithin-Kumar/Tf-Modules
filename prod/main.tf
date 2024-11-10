#This Terraform Code Deploys Basic VPC Infra.
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "knnithinkumar-terra"
    key    = "prod.tfstate"
    region = "us-east-1"
  }
}
# Consuming the modules 

# Consuming VPC module for DEV environment

module "prod_vpc_1" {
  source              = "../modules/network"
  vpc_name            = "prod_vpc_01"
  vpc_cidr            = "10.0.0.0/16"
  environment         = "prod"
  public_cird_block   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_cird_block  = ["10.0.10.0/24", "10.0.20.0/24"]
  azs                 = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnet_name  = "App-public"
  private_subnet_name = "Db-private"
}
