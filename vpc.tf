provider "aws" {
    region = "eu-west-2"
}

variable vpc_cidr_block {}
variable private_subnet_cidr_blocks {}
variable public_subnet_cidr_blocks {}


data "aws_availability_zones" "azs" {}

module "myapp-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.12.0"
  # insert the 23 required variables here

  name = "myapp-vpc"
  cidr = var.vpc_cidr_block

  # Recommended to have one private subnet and one public subnet on each AZ
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets = var.public_subnet_cidr_blocks

  #AZ to deploy subnets
  #azs = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  #Set AZ's dynamically depending on the region by using data to query aws to provide all az in the rejoin
  azs = data.aws_availability_zones.azs.names

  enable_nat_gateway = true
  single_nat_gateway = true # A shared nat gateway for all private subnets to route traffic
  enable_dns_hostnames = true 

# This tag allows the cloud control manager to identify which vpc it should connect to
  tags = {
      "kubernetes.io/cluster/myapp-eks-cluster" = "shared" 
  }

# This tag allows the cloud control manager to identify which subnet it should connect to
  public_subnet_tags = {
      "kubernetes.io/cluster/myapp-eks-cluster" = "shared" 
      "kubernetes.io/role/elb" = 1
  }

  # This tag allows the cloud control manager to identify which subnet it should connect to
  private_subnet_tags = {
      "kubernetes.io/cluster/myapp-eks-cluster" = "shared" 
      "kubernetes.io/role/internal-elb" = 1
  }
}