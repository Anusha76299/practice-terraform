
resource "aws_vpc" "vpc1" {
  cidr_block = "${var.cidr_block}"
	tags = { 
  		Name = "vpc1"
	}
}

resource "aws_subnet" "main" {
  vpc_id     = "${var.vpc1_id}"
  cidr_block = "${var.sub-cidr_block}"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet1"
  }
}
resource "aws_subnet" "public" {
  vpc_id     = "${var.vpc1_id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet2"
  }
}
resource "aws_security_group" "sg1" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${var.vpc1_id}"

  ingress {
    description      = "TLS from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${var.vpc1_id}"

  tags = {
    Name = "ig"
  }
}
resource "aws_route_table" "rt1" {
  vpc_id = "${var.vpc1_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  }
resource "aws_route_table_association" "rt2" {
  subnet_id      = "${var.subnet_id}"
  route_table_id = aws_route_table.rt1.id
}

output "vpc1_id" {
    value = "${aws_vpc.vpc1.id}"
  
}

output "subnet_id" {
  value = "${aws_subnet.main.id}"
}
output "subnet_id2" {
  value = "${aws_subnet.public.id}"
}

output "ig_sg" {
  value = "${aws_security_group.sg1.id}"
}