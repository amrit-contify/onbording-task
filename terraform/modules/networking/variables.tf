variable "project_name" {
  description = "Used to name all resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "allowed_ssh_cidr" {
  description = "List of CIDRs allowed to SSH into EC2"
  type        = list(string)
  default     = ["0.0.0.0/0"] # restrict to your IP in real projects
}
