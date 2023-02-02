terraform {
  required_providers {
    aws = {
      source    = "hashicorp/aws"
      version   = "4.36.1"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.4.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "kubectl" {
  host                   = data.aws_eks_cluster.example.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.example.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.main.token
  load_config_file       = false
}

data "aws_eks_cluster" "example" {
  name = var.ClusterName
}
data "aws_eks_cluster_auth" "main" {
  name = var.ClusterName
} 

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.example.endpoint
    token                  = data.aws_eks_cluster_auth.main.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.example.certificate_authority.0.data)
  }
}



