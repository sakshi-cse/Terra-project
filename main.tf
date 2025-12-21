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



module "eks" {
  source = "./modules/eks"

  cluster_name        = "${var.project_name}-${var.environment}-eks"
  kubernetes_version  = 1.33

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  node_instance_types = var.node_instance_types
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
  node_desired_size   = var.node_desired_size


  environment = var.environment
}