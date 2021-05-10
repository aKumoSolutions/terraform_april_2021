############### EC2 ################
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux_2.image_id  # data sources reference
  instance_type          = var.instance_type                     # variable
  vpc_security_group_ids = [aws_security_group.web_server_sg.id] # resources reference
  key_name               = aws_key_pair.terraform_key.key_name   # resources reference
  tags                   = local.common_tags

  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip
      private_key = file("~/.ssh/id_rsa")
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo cp /tmp/index.html /var/www/html/index.html",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",
      "sudo touch test.txt"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip
      private_key = file("~/.ssh/id_rsa")
    }
  }
}
############### Key Pair ###################
resource "aws_key_pair" "terraform_key" {
  key_name   = "Terraform-Server"
  public_key = file("~/.ssh/id_rsa.pub")
}

############### Security Group ##############
resource "aws_security_group" "web_server_sg" {
  name        = "web"
  description = "this is for a web server"

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_server_sg"
  }
}
