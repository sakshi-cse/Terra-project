module "vpc" {
  source = "./modules/vpc" 
  
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id           = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets[0]
 
}