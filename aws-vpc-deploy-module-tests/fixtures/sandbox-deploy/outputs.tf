output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.aws_vpc_deploy_module.vpc_id
}

output "vpc_name" {
  description = "The name tag of the VPC"
  value       = module.aws_vpc_deploy_module.vpc_name
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = module.aws_vpc_deploy_module.internet_gateway_id
}

output "internet_gateway_name" {
  description = "The name tag of the Internet Gateway"
  value       = module.aws_vpc_deploy_module.internet_gateway_name
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.aws_vpc_deploy_module.public_subnet_ids
}

output "public_subnet_names" {
  description = "The name tags of the public subnets"
  value       = module.aws_vpc_deploy_module.public_subnet_names
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.aws_vpc_deploy_module.private_subnet_ids
}

output "private_subnet_names" {
  description = "The name tags of the private subnets"
  value       = module.aws_vpc_deploy_module.private_subnet_names
}

output "nat_gateway_ids" {
  description = "The IDs of the NAT Gateways"
  value       = module.aws_vpc_deploy_module.nat_gateway_ids
}

output "nat_gateway_names" {
  description = "The name tags of the NAT Gateways"
  value       = module.aws_vpc_deploy_module.nat_gateway_names
}

output "private_route_table_ids" {
  description = "The IDs of the route tables for private subnets"
  value       = module.aws_vpc_deploy_module.private_route_table_ids
}

output "private_route_table_names" {
  description = "The name tags of the route tables for private subnets"
  value       = module.aws_vpc_deploy_module.private_route_table_names
}
