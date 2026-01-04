module "ecr" {
  source = "terraform-aws-modules/ecr/aws"
  repository_name = var.repo_name
  
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description = "Keep last 3 tagged images"
        selection = {
          tagStatus = "tagged"
          tagPrefixList = ["v"]
          countType = "imageCountMoreThan"
          countNumber = 3
        }
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
