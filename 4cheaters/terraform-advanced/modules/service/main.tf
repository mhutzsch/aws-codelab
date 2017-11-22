resource "aws_security_group" "instance" {
  name = "Allow ELB access to instance"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    security_groups = ["${aws_security_group.elb.id}"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.team_name}-${var.service_name}-instance-sg"
  }
}

resource "aws_autoscaling_group" "service" {
  name_prefix = "${var.team_name}-${var.service_name}-"
  launch_configuration = "${aws_launch_configuration.service.id}"
  max_size = 2
  min_size = 1
  desired_capacity = 1
  vpc_zone_identifier = ["${var.public_subnet_ids}"]
  load_balancers = ["${aws_elb.service.id}"]
  health_check_type = "ELB"
  health_check_grace_period = 120
  wait_for_capacity_timeout = "3m"

  lifecycle {create_before_destroy = true}

  tags = [
    {
      key = "Name"
      value = "${var.team_name}-${var.service_name}"
      propagate_at_launch = true
    }
  ]
}
