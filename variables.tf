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