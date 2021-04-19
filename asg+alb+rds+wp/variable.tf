variable "env" {
  description = "Name of the environment"
  default     = "dev"
  type        = string
}

variable "instance_type" {}

variable "skip_snapshot" {
  type    = bool
  default = true
}