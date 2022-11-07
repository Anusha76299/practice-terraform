resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"

	tags = { 
  		Name = "vpc1"
	}
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private_subnet"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public_subnet"
  }
}
