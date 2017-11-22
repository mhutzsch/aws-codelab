provider "aws" {
  region = "eu-central-1"
  profile = "k2tf-nonlive-admin"
}

data "aws_availability_zones" "current" {}
