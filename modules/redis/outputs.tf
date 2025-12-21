output "redis_primary_endpoint" {
  value       = module.elasticache.cluster_configuration_endpoint
}

