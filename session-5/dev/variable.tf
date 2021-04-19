variable "env" {
  type        = string
  description = "Name of the environment"
}

variable "instance_type" {
  type        = string
  description = "this is an instance type"
}

variable "web_sg_tcp_ports" {
  type = list(string)
}

variable "web_sg_tcp_ports_cidr" {
  type = list(string)
}