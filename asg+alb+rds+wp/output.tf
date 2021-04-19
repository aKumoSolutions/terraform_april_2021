output "lb_dns" {
    value = aws_lb.webserver_alb.dns_name
}

output "db_name" {
    value = aws_db_instance.rds.name
}

output "db_master_username" {
    value = aws_db_instance.rds.username
}

output "db_master_user_password" {
    value = aws_db_instance.rds.password
}

output "db_endpoint" {
    value = aws_db_instance.rds.endpoint
}