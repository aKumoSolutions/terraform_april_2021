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
  final_snapshot_identifier = var.snapshot == true ? null : "${var.env}-snapshot"
  vpc_security_group_ids = []
  publicly_accessible  = var.env == "dev" ? true : false
}


