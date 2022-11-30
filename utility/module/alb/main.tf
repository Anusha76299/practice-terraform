resource "aws_lb" "test" {
  name               = "lb2"
  internal           = false
  load_balancer_type = "${var.lb_type}"
  security_groups    = ["${var.ig_sg}"]
  subnets            = [var.subnet_id,var.subnet_id2]

  enable_deletion_protection = false

}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "${var.port}"
  protocol          = "${var.protocol}"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
 # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}

resource "aws_lb_target_group" "test" {
  name     = "alb-target1"
  port     = var.port
  protocol = "${var.protocol}"
  vpc_id   = "${var.vpc1_id}"
}
resource "aws_lb_target_group_attachment" "test1" {
  
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = "${var.instance}"
  port             = "${var.port}"
}
resource "aws_lb_target_group_attachment" "test2" {
  
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = var.instance2
  port             = "${var.port}"
}