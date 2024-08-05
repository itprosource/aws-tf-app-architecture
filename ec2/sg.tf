resource "aws_security_group" "main" {
  name        = "${var.application_name}-main-sg"
  description = "Main Security Group for ${var.application_name}-server."
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.application_name}-main-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "public_https" {
  count             = var.enable_public_https ? 1 : 0
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "ec2_instance_connect" {
  count             = var.allow_ec2_instance_connect ? 1 : 0
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = data.external.get_ec2_connect_ip.result.ec2_connect_ip
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "other_rules" {
  for_each          = var.other_sg_rules
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = each.value.cidr
  from_port         = each.value.from_port
  ip_protocol       = each.value.protocol
  to_port           = each.value.tp_port
  description       = each.value.description
}

