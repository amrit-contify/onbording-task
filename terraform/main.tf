# -------------------------------------------------------
# ROOT MODULE
# Calls networking + compute modules
# -------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Step 1: Create VPC + Subnet + Security Group
module "networking" {
  source = "./modules/networking"

  project_name     = var.project_name
  vpc_cidr         = var.vpc_cidr
  subnet_cidr      = var.subnet_cidr
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

# Step 2: Create EC2 using outputs from networking module
module "compute" {
  source = "./modules/compute"

  project_name      = var.project_name
  subnet_id         = module.networking.subnet_id
  security_group_id = module.networking.security_group_id
}
