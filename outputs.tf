###############vpc##############
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_public_subnets" {
  value = module.vpc.public_subnets
}
output "vpc_private_subnets" {
  value = module.vpc.private_subnets
}

#########EC2#############
output "ec2_bastion_instance_id" {
  value = module.ec2.bastion_instance_id
}

output "ec2_bastion_public_ip" {
  value = module.ec2.bastion_public_ip
}

output "ec2_bastion_private_ip" {
  value = module.ec2.bastion_private_ip
}
output "ec2_bastion_security_group_id" {
    value = module.ec2.bastion_security_group_id
}

################s3_cdn#############
output "s3_bucket_name" {
  value = module.s3_cdn.s3_bucket_id
}
output "s3_bucket_bucket_domain_name" {
  value = module.s3_cdn.s3_bucket_bucket_domain_name
}

output "cloudfront_distribution_id" {
  value = module.s3_cdn.cloudfront_distribution_id
}


output "cloudfront_distribution_domain_name" {
  value = module.s3_cdn.cloudfront_distribution_domain_name
}

##############RDS##############

output "rds_primary_endpoint" {
  value       = module.rds.rds_primary_endpoint
}

output "rds_password" {
  value = module.rds.rds_password
  sensitive = true
}



##########redis#########
output "redis_primary_endpoint" {
  value = module.redis.redis_primary_endpoint
}

output "redis_reader_endpoint" {
  value = module.redis.redis_reader_endpoint
}
################ecr##########
output "ecr_repository_url" {
  value = module.ecr.repository_url
}  

##########eks############
output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_arn" {
  value = module.eks.eks_cluster_arn
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

