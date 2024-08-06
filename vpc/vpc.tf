resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr

  tags = {
    Name = "${var.application_name}-vpc"
    application = var.application_name
  }
}

resource "aws_subnet" "public" {

  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.application_name}-public"
    application = var.application_name
  }
}

resource "aws_subnet" "db" {

  vpc_id     = aws_vpc.main.id
  cidr_block = var.db_cidr

  tags = {
    Name = "${var.application_name}-db"
    application = var.application_name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.application_name}-igw"
  }
}