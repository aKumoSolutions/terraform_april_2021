module "ec2_module" {
    source = "../../modules/ec2"

    env = "qa"
    instance_type = "t2.micro"
    ami = "ami-0cf6f5c8a62fa5da6"
}