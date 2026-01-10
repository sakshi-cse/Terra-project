variable "project_name" {
    type = string
    default = "demo"
}

variable "ecr_repo" {
    type = string
    default = "app-dev-ecr"
}
variable "aws_region" {
  type    = string
  default = "us-west-1"
}
