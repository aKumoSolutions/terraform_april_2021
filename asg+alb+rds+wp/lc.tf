data "aws_ami" "amznlinux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "template_file" "user_data" {
  template = file("user_data.sh")
  vars = {
    env = var.env
  }
}

resource "aws_security_group" "webserver_sg" {
  name        = "${var.env}-webserve-sg"
  description = "Allow http inbound traffic"

  tags = {
    Name = "${var.env}-webserve-sg"
  }
}

resource "aws_security_group_rule" "http_from_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id        = aws_security_group.webserver_sg.id
}

resource "aws_security_group_rule" "sql_from_rds" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.rds_sg.id
  security_group_id        = aws_security_group.webserver_sg.id
}

resource "aws_security_group_rule" "egress_webserver" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver_sg.id
}

resource "aws_launch_configuration" "webserver_lc" {
  name_prefix   = "${var.env}-webserve-lc"
  image_id      = data.aws_ami.amznlinux2.image_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.terraform_server_key.key_name

  lifecycle {
    create_before_destroy = true
  }

  user_data       = data.template_file.user_data.rendered
  security_groups = [aws_security_group.webserver_sg.id]
}

resource "aws_key_pair" "terraform_server_key" {
  key_name   = "Terraform-Server"
  public_key = file("~/.ssh/id_rsa.pub")
}