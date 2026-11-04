output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "security_group_id" {
  description = "Security Group ID"
  value       = module.networking.security_group_id
}

output "instance_id" {
  description = "EC2 Instance ID"
  value       = module.compute.instance_id
}

output "public_ip" {
  description = "EC2 Public IP"
  value       = module.compute.public_ip
}
