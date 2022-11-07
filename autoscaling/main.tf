resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Main"
  }
}
resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Main"
  }
}
resource "aws_security_group" "sg1" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

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
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ig"
  }
}
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  }
resource "aws_route_table_association" "rt2" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.rt1.id
}
resource "aws_instance" "test-ec2-instance" {
  subnet_id = aws_subnet.sub1.id
  ami = "ami-09d3b3274b6c5d4aa"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.sg1.id}"]
  tags = {
    Name = "ec2"
  }
}
  resource "aws_lb_target_group" "test" {
  name     = "test"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}
resource "aws_lb" "test1" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg1.id]
  subnet_mapping {
    subnet_id     = aws_subnet.sub1.id
    }
    subnet_mapping {
    subnet_id     = aws_subnet.sub2.id
    }

  enable_deletion_protection = false
  }
  resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test1.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}
resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "terraform-lc-example-"
  image_id      = data.aws_ami.myimage.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.sg1.id]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bar" {
  name                 = "terraform-asg-example"
  launch_configuration = aws_launch_configuration.as_conf.name
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  vpc_zone_identifier  = [aws_subnet.sub1.id, aws_subnet.sub2.id]

}
data "aws_ami" "myimage" {
  most_recent = true

  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
}
