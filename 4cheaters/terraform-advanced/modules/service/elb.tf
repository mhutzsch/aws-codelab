resource "aws_security_group" "elb" {
  name = "Allow public access via http"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.team_name}-${var.service_name}-elb-sg"
  }
}

resource "aws_elb" "service" {
  name = "${var.team_name}-${var.service_name}-elb"
  subnets = ["${var.public_subnet_ids}"]
  security_groups = ["${aws_security_group.elb.id}"]
  listener {
    instance_port = 8080
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    interval = 5
    target = "HTTP:8080/status"
    timeout = 2
    unhealthy_threshold = 2
  }
}
