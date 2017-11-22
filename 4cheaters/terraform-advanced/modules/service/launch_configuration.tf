data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.tpl")}"
}

resource "aws_launch_configuration" "service" {
  name_prefix = "${var.team_name}-${var.service_name}-"
  image_id = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.sshkeyname}"
  user_data = "${data.template_file.userdata.rendered}"
  security_groups = [
    "${aws_security_group.instance.id}"
  ]
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}
