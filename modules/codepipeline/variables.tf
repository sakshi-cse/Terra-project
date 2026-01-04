variable "environment" {
  type = string
  default = "dev"
}
variable "project_name" {
  type = string
  default = "demo"
}

variable "github_owner" {}
variable "github_repo" {}
variable "github_token" {}
variable "codebuild_project" {}