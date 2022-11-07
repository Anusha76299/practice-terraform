resource "aws_instance" "ec2" {

  subnet_id = aws_subnet.main.id
  ami = var.myami //ap-south-1
  instance_type = "t3.small"
  count = 1
  tags = {
    Name = "visualscrapy"
  }
}

resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  #security_groups    = [aws_security_group.lb_sg.id]
  subnet            = [aws_subnet.main.id]

  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}
