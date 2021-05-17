module "s3_module" {
    # remote module
    source = "github.com/aKumoSolutions/terraform_april_2021/modules/s3"
    # variables in module
    
    env = "dev"  
}

module "s3_module_virginia" {
    # remote module
    source = "github.com/aKumoSolutions/terraform_april_2021/modules/s3"
    # variables in module
    
    env = "dev1"  
    providers = {
        aws = aws.virginia
    }
}

output "s3_module_bucket_name" {
    value = module.s3_module.id
}