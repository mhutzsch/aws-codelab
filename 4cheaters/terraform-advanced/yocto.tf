data "aws_ami" "latest" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn-ami-*-x86_64-gp2"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

module "yocto" {
  source = "./modules/service"

  ami_id = "${data.aws_ami.latest.id}"
  instance_type = "t2.nano"
  profile = "${var.profile}"
  public_subnet_ids = ["${module.vpc.public_subnets}"]
  sshkeyname = "some-keypair"
  team_name = "k2tf"
  vpc_id = "${module.vpc.vpc_id}"
  service_name = "yocto"
}
