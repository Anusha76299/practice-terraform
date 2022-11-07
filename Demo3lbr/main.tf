resource "aws_vpc" "itaxvpc1" {
     cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet1pri" {
    vpc_id = aws_vpc.itaxvpc1.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-west-2a"
    
}

resource "aws_subnet" "subnet2pub" {
    vpc_id = aws_vpc.itaxvpc1.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-west-2b"
    map_public_ip_on_launch = true
}