

#vpc

resource "aws_vpc" "first-vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "production"
  }

}

#subnet-1

resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.first-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "prod-subnet"
  }
}

#subnet-2

resource "aws_subnet" "subnet-2" {
  vpc_id     = aws_vpc.first-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "prod-subnet2"
  }
}

resource "aws_eks_cluster" "eksdemo" {
  name     = "${var.eks_cluster}"
  role_arn = aws_iam_role.eksdemorole.arn

  vpc_config {
    subnet_ids = [aws_subnet.subnet-1.id,aws_subnet.subnet-2.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eksdemorole-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eksdemorole-AmazonEKSVPCResourceController,
  ]
}


## IAM ROLE

resource "aws_iam_role" "eksdemorole" {
  name = "eks-cluster-role"

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

resource "aws_iam_role_policy_attachment" "eksdemorole-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eksdemorole.name
}


resource "aws_iam_role_policy_attachment" "eksdemorole-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eksdemorole.name
}


#enabling IAM role for service accounts

data "tls_certificate" "ekstls" {
  url = aws_eks_cluster.eksdemo.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eksopidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = data.tls_certificate.ekstls.certificates[*].sha1_fingerprint
  url             = aws_eks_cluster.eksdemo.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "eksdoc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eksopidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eksopidc.arn]
      type        = "Federated"
    }
  }
}


#Variables

variable "eks_cluster"{
    type = string
    default = "eksclusterdemo"
}

# WORKERS NODE

resource "aws_eks_node_group" "eksnode" {
  cluster_name    = aws_eks_cluster.eksdemo.name
  node_group_name = "eksnodegroup"
  node_role_arn   = aws_iam_role.eksnoderole.arn
  subnet_ids      = [aws_subnet.subnet-1.id,aws_subnet.subnet-2.id]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eksnode-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eksnode-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eksnode-AmazonEC2ContainerRegistryReadOnly,
  ]
}



#IAM role for EKS Nodes

resource "aws_iam_role" "eksnoderole" {
  name = "eksnoderole"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eksnode-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eksnoderole.name
}

resource "aws_iam_role_policy_attachment" "eksnode-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eksnoderole.name
}

resource "aws_iam_role_policy_attachment" "eksnode-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eksnoderole.name
}
