variable "user" {
  description = "AWS user name"
  type = string
  default = "sakshi-devops"
}
variable "project_name" {
  description = "Name of the project"
  type = string
  default = "demo"
}

variable "environment" {
  description = "Environment name"
  type = string
  default = "dev"
}
variable "region" {
  description = "AWS region to deploy resources"
  type = string
  default = "us-west-1"
}