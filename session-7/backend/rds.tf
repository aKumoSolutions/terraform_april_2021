resource "aws_db_instance" "rds" {
  allocated_storage    = 
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  identifier           = "${var.env}-instance"
  name                 = "wordpress"
  username             = "admin"
  password             = 
  skip_final_snapshot  = true
}