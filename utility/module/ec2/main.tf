resource "aws_instance" "webserver1" {
  
  subnet_id = var.subnet_id
  ami = "${var.ami}" //ap-south-1
  instance_type = "${var.instance_type}"
  #user_data = "${file("userdata.sh")}"
  tags = {
    Name = "webserver"
  }
  #associate_public_ip_address = "true"
  key_name = "jenkinsKP"
}

resource "aws_instance" "webserver2" {
  
  subnet_id = var.subnet_id2
  ami = "${var.ami}" //ap-south-1
  instance_type = "${var.instance_type}"
  #user_data = "${file("userdata.sh")}"
  tags = {
    Name = "webserver2"
  }
  #associate_public_ip_address = "true"
  key_name = "jenkinsKP"
}

output "instance" {
  value = "${aws_instance.webserver1.id}"
}

output "instance2" {
  value = "${aws_instance.webserver2.id}"
}
