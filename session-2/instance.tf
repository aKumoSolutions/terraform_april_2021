resource "aws_instance" "first" {
  ami           = "ami-05d72852800cbf29e"
  instance_type = "t2.micro"
  tags = {
    Name = "Instance-2"
  }
}
