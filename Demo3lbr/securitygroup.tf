resource "aws_security_group" "s1" {
    vpc_id = aws_vpc.itaxvpc1.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 8080
        to_port = 8081
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "s2" {
    vpc_id = aws_vpc.itaxvpc1.id
    ingress{
        from_port = 0
        to_port = 6553
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }

    egress{
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
}
/* for public subnet we need internet gateway..for private subnet we need NAT gateway */

resource "aws_internet_gateway" "igw1" {
    vpc_id = aws_vpc.itaxvpc1.id
    tags = {
        name = "igw"
    }
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.itaxvpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }
}

resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.subnet2pub.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_instance" "ec2lbr1" {
        subnet_id = aws_subnet.subnet1pri.id
        instance_type = "t2.micro"
        ami = "ami-08e2d37b6a0129927"
        vpc_security_group_ids = [aws_security_group.s1.id]
    }     
    resource "aws_s3_bucket" "itaxbucket1" {
    bucket = "itaxbucket1"
    tags = {
        Name = "My bucket"
        Environment = "Dev"
  }
} 
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = true
  load_balancer_type = "application"
  subnet_mapping {
            subnet_id            = aws_subnet.subnet1pri.id
       }
       subnet_mapping {
            subnet_id            = aws_subnet.subnet2pub.id
            }

  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.itaxbucket1.bucket
    prefix  = "test-lb"
    enabled = false
  }

  tags = {
    Environment = "production"
  }
}
