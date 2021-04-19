resource "aws_security_group" "first_sg" {
  name        = "web"
  description = "this is for a web server"
  tags = {
    Name = "first_sg"
  }
}
resource "aws_security_group_rule" "web_ingress" {
  count = 3 # the value is 3 because "web_sg_tcp_ports" list has 3 values.
  type = "ingress"
  protocol = "tcp"
  security_group_id = aws_security_group.first_sg.id
  from_port = element(var.web_sg_tcp_ports, count.index)
  to_port   = element(var.web_sg_tcp_ports, count.index)
  cidr_blocks = [element(var.web_sg_tcp_ports_cidr, count.index)]
}

