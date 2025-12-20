variable "key_name" {
  default = "bastion-server"
}

variable "ami_id" {
  default = "ami-04f34746e5e1ec0fe"
}

variable "instance_type" {
  default = "t3.small"
}
variable "allowed_ip" {
  default = "103.184.70.183/32"
}
variable "vpc_id"{
  type = string
}

variable "public_subnets" {
  type = string
}