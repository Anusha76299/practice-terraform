/*module "vpc"{
  source = "C:/Users/ANUSHA/terraform/Practice/modulelb/vpc"
}*/

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.2.1"
  enable_deletion_protection = false
  load_balancer_type = "application"
  name = "alb1"
  #security_groups = "sg-029e41a6dbae6810e - allow_tls"
  #vpc_id          = data.aws_vpc.default.id
  #security_groups = [module.security_group.security_group_id]
  subnets         = [aws_subnet.sub1.id,aws_subnet.sub2.id]
  vpc_id = [ module.alb.vpc_id ]
}