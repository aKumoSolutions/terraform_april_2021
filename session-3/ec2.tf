resource "aws_instance" "first_ec2" {
  ami                    = "ami-05d72852800cbf29e"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.first_sg.id]
  key_name               = "MainSessionMAC"
  user_data              = file("userdata.sh")


  tags = {
    Name = var.env
  }
}



