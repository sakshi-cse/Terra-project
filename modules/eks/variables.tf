variable "aws_region" {
  type    = string
  default = "us-west-1"
}

variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.33"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "control_plane_subnet_ids" {
  type = list(string)
}

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
variable "namespace" {
  type = string
  default = "dev"
}

variable "environment" {
  type    = string
  default = "dev"
}
variable "project_name" {
  type = string
  default = "demo"
}