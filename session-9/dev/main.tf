module "ec2_module" {
    # local module
    source = "../../modules/ec2"
    # variables in module
    env = "dev"
    instance_type = "t2.micro"
    ami = "ami-0cf6f5c8a62fa5da6"
    
}