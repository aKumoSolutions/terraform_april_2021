locals {
    tags = {
        Name = "${var.env}-main"
        Environment = var.env
    }
}