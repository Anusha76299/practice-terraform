module "my_vpc" {
    source = "../module/vpc"
    cidr_block = "10.0.0.0/16"
    sub-cidr_block = "10.0.1.0/24"
    vpc1_id = "${module.my_vpc.vpc1_id}"
    subnet_id = "${module.my_vpc.subnet_id}"
    subnet_id2 = "${module.my_vpc.subnet_id2}"
    ig_sg = "${module.my_vpc.ig_sg}"
}

module "ec2" {
  source = "../module/ec2"
  subnet_id = "${module.my_vpc.subnet_id}"
  subnet_id2 ="${module.my_vpc.subnet_id2}"
  ami = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
  instance = "${module.ec2.instance}"
  instance2 = "${module.ec2.instance2}"
}

module "alb1" {
  source = "../module/alb"
  lb_type = "application"
  ig_sg = "${module.my_vpc.ig_sg}"
  port = 8080
  protocol = "HTTP"
  vpc1_id = "${module.my_vpc.vpc1_id}"
  instance = "${module.ec2.instance}"
  instance2 = "${module.ec2.instance2}"
  subnet_id = "${module.my_vpc.subnet_id}"
  subnet_id2 ="${module.my_vpc.subnet_id2}"
}