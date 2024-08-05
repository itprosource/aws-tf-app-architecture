data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  network_interface {
    network_interface_id = aws_network_interface.app.id
    device_index         = 0
  }

  tags = {
    Name = "${var.application_name}-server"
  }
}

resource "aws_network_interface" "app" {
  subnet_id   = var.subnet_id
  security_groups = [aws_security_group.main.id]

  tags = {
    Name = "${var.application_name}-eni"
  }
}