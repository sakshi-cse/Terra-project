resource "aws_s3_bucket" "artifacts" {
  bucket = "${var.project_name}-pipeline-artifacts"
}

resource "aws_codestarconnections_connection" "github" {
  name = "${var.project_name}-github-conn"
  provider_type = "GitHub"
}


resource "aws_iam_role" "pipeline_role" {
  name = "codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codepipeline.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "pipeline_admin" {
  role = aws_iam_role.pipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_codepipeline" "this" {
  name = var.project_name
  role_arn = aws_iam_role.pipeline_role.arn

  artifact_store {
    type = "S3"
    location = aws_s3_bucket.artifacts.bucket
  }

  stage {
    name = "Source"

    action {
      name = "GitHub_Source"
      category = "Source"
      owner = "AWS"
      provider = "CodeStarSourceConnection"
      version = "1"        
      output_artifacts = ["source"]

      configuration = {
        ConnectionArn = aws_codestarconnections_connection.github.arn
        FullRepositoryId = "${var.github_repo}"
        BranchName = "main"
        DetectChanges = true

      }
    }
  }

  stage {
    name = "Build"

    action {
      name = "CodeBuild"
      category = "Build"
      owner = "AWS"
      provider = "CodeBuild"
      version = "1" 
      input_artifacts = ["source"]

      configuration = {
        ProjectName = var.codebuild_project
      }
    }
  }
}