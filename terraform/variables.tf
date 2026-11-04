variable "project_name" {
  description = "Prefix for all resource names"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDRs allowed to SSH into the EC2"
  type        = list(string)
}
