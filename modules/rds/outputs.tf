
output "rds_primary_endpoint" {
  value = module.rds_instance.db_instance_endpoint
}



output "rds_sg_id" {
  description = "Security Group ID used by RDS"
  value = aws_security_group.rds.id
}

output "rds_password" {
  value = random_password.rds.result
  sensitive = true
}


