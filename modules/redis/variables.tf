

variable "port" {
  type    = number
  default = 6379
}

variable "private_subnets" {
  type = list(string)
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

variable "replication_group_id" { 
    type = string 
    default = "demo-redis-dev"
    
}  

variable "node_type" { 
    type = string 
    default = "cache.t3.small"
}
variable "num_node_groups" { 
    type = number
    default = 1 
    
}
variable "replicas_per_node_group" { 
    type = number
    default = 1 
}
variable "automatic_failover_enabled" { 
    type = bool
    default = true 
}

variable "engine" { 
    type = string
    default = "redis" 
}
variable "engine_version" { 
    type = string
    default = "7.0" 
    
}
variable "parameter_group_name" { 
    type = string
    default = "default.redis7" 
}
