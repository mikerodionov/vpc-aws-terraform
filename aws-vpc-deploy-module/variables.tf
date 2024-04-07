variable "region" {
  description = "AWS region"
  validation {
    condition = contains(["us-east-1", "us-west-1", "us-west-2", "eu-west-1", "eu-central-1", "ap-southeast-1", "ap-southeast-2", "ap-northeast-1", "ap-northeast-2", "sa-east-1"], var.region)
    error_message = "Invalid AWS region. Allowed values are: us-east-1, us-west-1, us-west-2, eu-west-1, eu-central-1, ap-southeast-1, ap-southeast-2, ap-northeast-1, ap-northeast-2, sa-east-1"
  }
}

variable "vpc_name" {
    description = "VPC name"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}

variable "subnet_count" {
  description = "Number of subnets (both public and private) to create (1-3)"
  validation {
    condition     = var.subnet_count >= 1 && var.subnet_count <= 3
    error_message = "Number of subnets must be between 1 and 3"
  }
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}