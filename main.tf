module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id  = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets[0]
 
}
module "s3_cdn" {
  source = "./modules/s3_cdn"

  project_name = var.project_name
  environment  = var.environment
  aws_region = var.region
}

module "rds" {
  source = "./modules/rds"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
 
}

module "redis" {
  source = "./modules/redis"
  vpc_id           = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

module "eks" {
  source = "./modules/eks"

  cluster_name = "${var.project_name}-${var.environment}-eks"
  kubernetes_version  = 1.33

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  node_instance_types = var.node_instance_types
  node_min_size = var.node_min_size
  node_max_size = var.node_max_size
  node_desired_size = var.node_desired_size


  environment = var.environment
}

module "ecr" {
  source    = "./modules/ecr"
  repo_name = var.ecr_repo_name
}

module "codebuild" {
  source = "./modules/codebuild"
  project_name = var.codebuild_project_name
  ecr_repo = module.ecr.repository_url
}

module "codepipeline" {
  source = "./modules/codepipeline"
  project_name = var.codepipeline_project_name
  github_owner = var.github_owner
  github_repo = var.github_repo
  github_token = var.github_token
  codebuild_project = module.codebuild.project_name
}
