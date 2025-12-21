###############vpc##############
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}
output "private_subnets" {
  value = module.vpc.private_subnets
}

#########EC2#############
output "bastion_instance_id" {
  value = module.ec2.bastion_instance_id
}

output "bastion_public_ip" {
  value = module.ec2.bastion_public_ip
}

output "bastion_private_ip" {
  value = module.ec2.bastion_private_ip
}
output "bastion_security_group_id" {
    value = module.ec2.bastion_security_group_id
}

################s3_cdn#############
#output "s3_bucket_name" {
#  value = module.s3_cdn.bucket_id
#}

#output "cdn_endpoint" {
 # value = module.s3_cdn.cloudfront_distribution_url
#}


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


##########eks############
output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

