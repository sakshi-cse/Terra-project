output "redis_primary_endpoint" {
  value = module.elasticache.replication_group_primary_endpoint_address
}

output "redis_reader_endpoint" {
  value = module.elasticache.replication_group_reader_endpoint_address
}