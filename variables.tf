variable "user" {
  description = "AWS user name"
  type = string
  default = "sakshi-devops"
}
variable "project_name" {
  type = string
  default = "demo"
}

variable "environment" {
  type = string
  default = "dev"
}
variable "region" {
  type = string
  default = "us-west-1"
}


#####eks####
variable "node_instance_types" {
  type    = list(string)
  default = ["t3.small"]
}

variable "node_min_size" {
  type    = number
  default = 1
}

variable "node_max_size" {
  type    = number
  default = 1
}

variable "node_desired_size" {
  type    = number
  default = 1
}



##ecr-build-pipeline###
variable "github_owner" {}
variable "github_repo" {}
variable "github_token" {
  sensitive   = true
}
variable "ecr_repo_name" {}
variable "codebuild_project_name" {}
variable "codepipeline_project_name" {}
