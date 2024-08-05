variable "application_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "enable_public_https" {
  type = bool
}

variable "vpc_id" {
  type = string
}

variable "allow_ec2_instance_connect" {
  type = bool
}

variable "other_sg_rules" {
  type = map(object({
    cidr_ipv4   = string
    from_port   = number
    to_port     = number
    ip_protocol = string
    description = string
  }))
}
