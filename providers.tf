provider "aws" {
  version = "~> 2.0"
  region = "ap-southeast-2"
  profile = lookup(var.profile, terraform.workspace)
}
