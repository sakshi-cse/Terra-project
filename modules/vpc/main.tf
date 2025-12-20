module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "6.5.0"
    name = var.project_name

    cidr = var.vpc_cidr
    region = var.region

    azs = var.azs
    public_subnets  = var.public_subnet_cidrs
    private_subnets = var.private_subnet_cidrs

    single_nat_gateway = true
    enable_nat_gateway = true
    tags = {
     Project     = var.project_name
     Environment = var.environment
     ManagedBy   = "terraform"
  } 

  


}