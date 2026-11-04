variable "project_name" {
  description = "Used to name all resources"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance (Amazon Linux 2023 in us-east-1)"
  type        = string
  default     = "ami-0866a3c8686eaeeba" # Amazon Linux 2023, us-east-1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro" # free tier eligible
}

variable "subnet_id" {
  description = "Subnet to launch EC2 in (from networking module)"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID (from networking module)"
  type        = string
}
