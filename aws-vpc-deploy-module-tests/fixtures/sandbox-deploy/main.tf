module "vpc" {
  source = "../vpc-aws-terraform/aws-vpc-deploy-module"

  vpc_name = "sandbox"

  region = "eu-central-1"

  vpc_cidr_block = "10.0.0.0/20"
  
  # Specify the CIDR blocks for your subnets
  public_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidr_blocks = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  
  # Specify the number of subnets to create (1-3)
  subnet_count = 2
}