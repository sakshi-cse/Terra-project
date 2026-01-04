
resource "aws_elasticache_subnet_group" "this" {
  name = "${var.project_name}-${var.environment}-redis-subnet-group"
  subnet_ids = var.private_subnets
}

module "elasticache" {
  source = "terraform-aws-modules/elasticache/aws"
  version = "1.10.3"

  create_security_group = false
  replication_group_id = var.replication_group_id
  description = "${var.project_name}-${var.environment}-redis"
  node_type = var.node_type
  num_node_groups = 1
  replicas_per_node_group = 0
  automatic_failover_enabled = false
  engine = var.engine
  engine_version = var.engine_version
  parameter_group_name = var.parameter_group_name
  port = var.port
  security_group_ids = [aws_security_group.redis.id]
  subnet_ids = var.private_subnets
  tags = {
    Name = "${var.project_name}-${var.environment}-redis"
    Environment = var.environment
  }
}

####Redis Security Group#####
resource "aws_security_group" "redis" {
  name = "redis-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    cidr_blocks = [var.allowed_ip]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-redis-sg"
  }
}