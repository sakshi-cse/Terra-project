###############vpc##############
output "vpc_id" {
  value       = module.vpc.vpc_id
}

#########EC2#############
output "bastion_instance_id" {
  value = module.ec2.bastion_instance_id
}

output "bastion_public_ip" {
  value = module.ec2.bastion_public_ip
}

output "bastion_private_ip" {
  value = module.ec2.bastion_private_ip
}