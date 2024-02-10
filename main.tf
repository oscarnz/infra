terraform {

  cloud {
    organization = "nazhan-infra"

    workspaces {
      name = "infra"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["eks.amazonaws.com", "ec2.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "example" {
#   name               = "eks-cluster-iam"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.example.name
# }

# resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.example.name
# }

# resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.example.name
# }

# resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.example.name
# }

# data "aws_subnet" "default_az1" {
#   id = var.subnet_id_1
# }

# data "aws_subnet" "default_az2" {
#   id = var.subnet_id_2
# }

# resource "aws_eks_cluster" "deployment" {
#   name     = "deployment"
#   role_arn = aws_iam_role.example.arn

#   vpc_config {
#     subnet_ids = [
#       data.aws_subnet.default_az1.id,
#       data.aws_subnet.default_az2.id,
#     ]
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
#   # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
#   depends_on = [
#     aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
#   ]
# }


# resource "aws_eks_node_group" "deployment" {
#   cluster_name    = aws_eks_cluster.deployment.name
#   node_group_name = "deployment"
#   node_role_arn   = aws_iam_role.example.arn
#   subnet_ids      = [data.aws_subnet.default_az1.id, data.aws_subnet.default_az2.id]

#   scaling_config {
#     desired_size = 1
#     max_size     = 1
#     min_size     = 1
#   }

#   instance_types = ["t3a.medium"]

#   update_config {
#     max_unavailable = 1
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
#   ]
# }

# data "aws_eks_cluster_auth" "deployment" {
#   name = aws_eks_cluster.deployment.name
# }

# # Use helm provider
# provider "kubernetes" {
#   # experiments {
#   #   manifest_resource = true
#   # }
#   host                   = aws_eks_cluster.deployment.endpoint
#   cluster_ca_certificate = base64decode(aws_eks_cluster.deployment.certificate_authority.0.data)
#   token                  = data.aws_eks_cluster_auth.deployment.token
# }
# provider "helm" {
#   debug = true
#   kubernetes {
#     host                   = aws_eks_cluster.deployment.endpoint
#     cluster_ca_certificate = base64decode(aws_eks_cluster.deployment.certificate_authority.0.data)
#     token                  = data.aws_eks_cluster_auth.deployment.token
#    }
# }

# data "tls_certificate" "deployment" {
#   url = aws_eks_cluster.deployment.identity[0].oidc[0].issuer
# }

# resource "aws_iam_openid_connect_provider" "deployment" {
#   client_id_list = ["sts.amazonaws.com"]
#   # https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html
#   # https://github.com/terraform-providers/terraform-provider-tls/issues/52
#   thumbprint_list = [data.tls_certificate.deployment.certificates[0].sha1_fingerprint]
#   url             = aws_eks_cluster.deployment.identity.0.oidc.0.issuer
# }