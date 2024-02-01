### GENERAL ###

variable "aws_region" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "environment" {
  type = string
}

variable "cert-manager-namespace" {
  type = string
}

#variable "kubectl-provider" {
#  type = string
#}

### NETWORKING MODULE ###

variable "vpc_cidr_block" {
  type = string
}


variable "public_subnets_cidr_blocks" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    public_subnet_1 = {
      cidr_block        = "10.10.100.0/24"
      availability_zone = "us-east-1a"
    }
    public_subnet_2 = {
      cidr_block        = "10.10.101.0/24"
      availability_zone = "us-east-1b"
    }
    public_subnet_3 = {
      cidr_block        = "10.10.102.0/24"
      availability_zone = "us-east-1c"
    }
  }
}

variable "private_subnets_cidr_blocks" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    private_subnet_1 = {
      cidr_block        = "10.10.10.0/24"
      availability_zone = "us-east-1a"
    }
    private_subnet_2 = {
      cidr_block        = "10.10.11.0/24"
      availability_zone = "us-east-1b"
    }
    private_subnet_3 = {
      cidr_block        = "10.10.12.0/24"
      availability_zone = "us-east-1c"
    }
  }
}

### EKS MODULE ###

variable "eks_cluster_name" {
  type = string
}

### EKS NODE GROUP ###

variable "desired_size" {
  type = string
}

variable "min_size" {
  type = string
}

variable "max_size" {
  type = string
}

variable "capacity_type" {
  type = string
}

variable "instance_types" {
  type = string
}

variable "max_unavailable" {
  type = string
}

### EKS CONFIGURATION ###

variable "eks_serviceaccount_name" {
  type = string
}

variable "serviceaccount_namespace" {
  type    = string
  default = "default"
}
### ARGOCD ###

variable "argocd_namespace" {
  type = string
}

variable "account_id" {
  type = string
}

### KARPETNER ###

variable "karpenter_serviceaccount_namespace" {
  type = string
}

variable "karpetner_eks_serviceaccount_name" {
  type = string
}