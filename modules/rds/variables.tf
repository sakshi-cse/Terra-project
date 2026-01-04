variable "identifier" {
  type = string
  default = "demo-db-dev"
}

variable "engine" {
  type = string
  default = "mysql"
}

variable "engine_version" {
  type = string
  default = "8.0"
}

variable "instance_class" {
  type = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type = number
  default = "20"
}

variable "db_name" {
  type = string
  default = "admin"
}

variable "username" {
  type = string
  default = "admin"
}

variable "port" {
  type = number
  default = 3306
}



variable "vpc_id" {
  type = string
}

variable "allowed_ip" {
  type = string
  default = "103.184.70.183/32"
}

variable "project_name" {
  type = string
  default = "demo"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "deletion_protection" {
  type = bool
  default = false
}


variable "private_subnets" {
  description = "Private subnets for DB"
  type = list(string)
}
