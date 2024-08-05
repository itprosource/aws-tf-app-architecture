locals {
  application_name = "test"
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../vpc"

  application_name = local.application_name
  
  vpc_cidr = "10.0.0.0/22"

  public_cidr = "10.0.0.0/26"
  db_cidr = "10.0.0.64/26"
}

module "ec2" {
  source = "../ec2"

  application_name = local.application_name

  vpc_id = module.vpc.vpc_id

  subnet_id = module.vpc.public_subnet_id

  enable_public_https = true
  allow_ec2_instance_connect = true
  other_sg_rules = {}
}