module "yocto" {
  source = "./modules/service"

  ami_id = "${data.aws_ami.latest.id}"
  instance_type = "t2.nano"
  profile = "${var.profile}"
  public_subnet_ids = ["${module.vpc.public_subnets}"]
  sshkeyname = "some-keypair"
  team_name = "some-team"
  vpc_id = "${module.vpc.vpc_id}"
  service_name = "yocto"
}
