locals {
    common_tags = {
        env = var.env
        project = "${var.env}-wordpress"
        team = "devops"
        owner = "kris"
        timestamp = timestamp()
    }
}

#comman 