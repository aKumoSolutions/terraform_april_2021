resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  identifier           = "${var.env}-instance"
  name                 = "wordpress"
  username             = "admin"
  password             = random_password.password.result
  skip_final_snapshot  = var.snapshot # false
  final_snapshot_identifier = var.snapshot == true ? null : "${var.env}-test-snapshot"
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible  = var.env == "dev" ? true : false
  tags = local.common_tags
}
resource "aws_security_group" "rds_sg" {
  name        = "${var.env}-rds-sg"
  description = "Allow MySQL"
  #vpc must be here if it is not default VPC. In our case, it is default VPC :)
}
resource "aws_security_group_rule" "http_from_lb" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_sg.id
}
resource "aws_security_group_rule" "rds_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_sg.id
}