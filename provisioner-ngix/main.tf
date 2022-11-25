resource "aws_instance" "web" {
  ami ="ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
  key_name = "jenkinsKP"
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "ec2-user"  #for linux it can be root
    private_key = file("./jenkinsKP.pem")   #the pem file to coonect using file function can pass password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
        inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras enable nginx1",
      "sudo yum -y install nginx",
      "sudo systemctl start nginx"
    ]
  }
}