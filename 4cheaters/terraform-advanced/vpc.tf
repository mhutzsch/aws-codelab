module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "1.3.0"

  azs = ["${data.aws_availability_zones.current.names}"]
  cidr = "${var.vpc_cidr}"
  public_subnets = ["${var.subnet_cidrs}"]
  enable_dns_support = true
}
