resource "aws_lb" "webserver_alb" {
  name               = "${var.env}-webserve-asg"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.aws_subnet_ids.default.ids

  tags = {
    name = "${var.env}-webserver-alb"
  }
}

resource "aws_lb_target_group" "webserver_tg" {
  name                          = "${var.env}-webserver-tg"
  port                          = 80
  protocol                      = "HTTP"
  vpc_id                        = data.aws_vpc.default.id
  load_balancing_algorithm_type = "least_outstanding_requests"
  health_check {
    path    = "/"
    port    = 80
    matcher = "200"
  }
}

resource "aws_lb_listener" "webserver_listener" {
  load_balancer_arn = aws_lb.webserver_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver_tg.arn
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "${var.env}-alb-sg"
  description = "Allow http inbound traffic"

  tags = {
    Name = "${var.env}-alb-sg"
  }
}

resource "aws_security_group_rule" "http_ingress" {
  description       = "This rule is for alb sg, and allows ingress"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}