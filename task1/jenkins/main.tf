resource "aws_instance" "jenkins1" {
  ami                       = "ami-09d3b3274b6c5d4aa"
  instance_type             = "t2.medium"
  #host_resource_group_arn   = "arn:aws:resource-groups:us-west-2:012345678901:group/win-testhost"
  #tenancy                   = "host"
  key_name = "jenkinsKP"
  user_data = "${file("userdata.sh")}"
  tags = {
    Name = "jenkins"
  }
}