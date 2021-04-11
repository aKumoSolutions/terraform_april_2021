output "ec2_public_ip" {
    value = aws_instance.first_ec2.public_ip
}

output "ec2_ami" {
    value = aws_instance.first_ec2.ami
}

