
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


variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
  default = "10.0.0.0/16"
}


variable "azs" {
  description = "List of availability zones"
  type = list(string)
  default = ["us-west-1a", "us-west-1c"]
}


variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type = list(string)

  default = ["10.0.101.0/24", "10.0.103.0/24"]
}


variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.3.0/24"]
}


variable "nat_gateway_count" {
  description = "Number of NAT Gateways"
  type = number
  default = 1
}


variable "enable_vpc_flow_logs" {
  description = "Enable VPC flow logs"
  type = bool
  default = false
}


