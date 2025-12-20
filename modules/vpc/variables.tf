
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


variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}


variable "azs" {
  type = list(string)
  default = ["us-west-1a", "us-west-1c"]
}


variable "public_subnet_cidrs" {
  type = list(string)

  default = ["10.0.101.0/24", "10.0.103.0/24"]
}


variable "private_subnet_cidrs" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.3.0/24"]
}


variable "nat_gateway_count" {
  type = number
  default = 1
}


variable "enable_vpc_flow_logs" {
  type = bool
  default = false
}


