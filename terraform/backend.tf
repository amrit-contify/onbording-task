terraform {
  backend "s3" {
    bucket       = "contify-onboarding-tfstate-amrit"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
