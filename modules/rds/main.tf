resource "random_password" "rds" {
  length  = 16
  special = true
}



module "rds_instance" {
  source = "terraform-aws-modules/rds/aws"
  version = "6.0.0"

  identifier = var.identifier

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  db_name  = var.db_name
  username = var.username
  port     = var.port

  vpc_security_group_ids = [aws_security_group.rds.id]

  allocated_storage = var.allocated_storage
  deletion_protection = var.deletion_protection
  password = random_password.rds.result
  create_db_parameter_group = true
  family = "mysql8.0"
  create_db_option_group     = true
  major_engine_version       = "8.0"


  tags = {
    Name = "${var.project_name}-${var.environment}-rds"
    Environment = var.environment
  }
}

####RDS Security Group#####
resource "aws_security_group" "rds" {
  name   = "rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-rds-sg"
  }
}