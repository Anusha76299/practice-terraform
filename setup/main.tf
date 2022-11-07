provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
}

module "anusha" {
    source = "../module/webserver"
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.0.0/16"
    name = "anu"
    ami = "ami-026b57f3c383c2eec"
    instance_type = "t2.micro"
}

/*output "instance_data" {
    value = module.anusha.instance
}*/
/*resource "aws_elb" "main" {
    instance = module.anusha.instance
} */

