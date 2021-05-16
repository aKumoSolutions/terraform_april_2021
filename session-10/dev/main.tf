module "s3_module" {
    # remote module
    source = "github.com/aKumoSolutions/terraform_april_2021/modules/s3"
    # variables in module
    
    env = "dev"  
}