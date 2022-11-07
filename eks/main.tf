resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"  
  #region = "us-east-1"
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



resource "aws_iam_role" "test_role" {
  name = "test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = <<POLICY

{

  "Version": "2012-10-17",

  "Statement": [

    {

      "Effect": "Allow",

      "Principal": {

        "Service": "eks.amazonaws.com"

      },

      "Action": "sts:AssumeRole"

    }

  ]

}

POLICY

}
  
  

resource "aws_eks_cluster" "example" {
  name     = "example"
  role_arn = aws_iam_role.test_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.sub1.id, aws_subnet.sub2.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  /*depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
  ]*/
}