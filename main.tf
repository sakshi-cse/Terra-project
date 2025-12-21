module "vpc" {
  source = "./modules/vpc" 
  
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id           = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets[0]
 
}
module "s3_cdn" {
  source = "./modules/s3_cdn"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.region
}

module "rds" {
  source = "./modules/rds"
  vpc_id           = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets[0]
 
}

module "redis" {
  source = "./modules/redis"
  vpc_id           = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}