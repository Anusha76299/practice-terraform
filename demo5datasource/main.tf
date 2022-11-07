data "aws_security_group" "selected" {
  name = "anusha"
  #id = "sg-040073c75afb6e0ac"
}
resource "aws_instance" "ec2" {
  ami = "ami-08e2d37b6a0129927"
  instance_type = "t2.micro"
  security_groups = [data.aws_security_group.selected.name]
  tags = {
    Name = "a1"
  }
  }