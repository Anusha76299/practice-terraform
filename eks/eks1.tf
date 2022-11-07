# Resource: aws_iam_role

/*resource "aws_iam_role" "my_eks" {

  # The name of the role

  name = "eks"



  assume_role_policy = <<POLICY

{

  "Version": "2012-10-17",

  "Statement": [

    {

      "Effect": "Allow",

      "Principal": {

        "Service": "eks.amazonaws.com"

      },

      "Action": "sts:AssumeRole"

    }

  ]

}

POLICY

}



resource "aws_iam_policy" "policy" {

  name        = "secret-policy"

  description = "A test policy"



  policy = <<EOF

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
            "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

}



resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"



  # The role the policy should be applied to

  role = aws_iam_role.my_eks.name

}



# Resource: aws_eks_cluster

resource "aws_eks_cluster" "eks" {

  name = var.environment == "development" ? var.environment : format("lacp-%s", lower(var.environment))

  #name     = "eks"

  role_arn = aws_iam_role.my_eks.arn




  version = "1.22"



  vpc_config {

    endpoint_private_access = false

    endpoint_public_access  = true



    #availability zones

    subnet_ids = [

      aws_subnet.sub1.id,

      aws_subnet.sub2.id,

    ]

  }



  depends_on = [

    aws_iam_role_policy_attachment.amazon_eks_cluster_policy

  ]

}
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"  
  #region = "us-east-1"
}
resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Main"
  }
}
resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Main"
  }
}




data "aws_eks_cluster_auth" "cluster" {

  name = aws_eks_cluster.eks.id

}*/