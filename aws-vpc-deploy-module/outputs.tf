output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "vpc_name" {
  description = "The name tag of the VPC"
  value       = aws_vpc.vpc.tags["Name"]
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "internet_gateway_name" {
  description = "The name tag of the Internet Gateway"
  value       = aws_internet_gateway.igw.tags["Name"]
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public_subnet.*.id
}

output "public_subnet_names" {
  description = "The name tags of the public subnets"
  value       = [for s in aws_subnet.public_subnet : s.tags["Name"]]
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private_subnet.*.id
}

output "private_subnet_names" {
  description = "The name tags of the private subnets"
  value       = [for s in aws_subnet.private_subnet : s.tags["Name"]]
}

output "nat_gateway_ids" {
  description = "The IDs of the NAT Gateways"
  value       = aws_nat_gateway.nat_gateway.*.id
}

output "nat_gateway_names" {
  description = "The name tags of the NAT Gateways"
  value       = [for g in aws_nat_gateway.nat_gateway : g.tags["Name"]]
}

output "private_route_table_ids" {
  description = "The IDs of the route tables for private subnets"
  value       = aws_route_table.private_route_table.*.id
}

output "private_route_table_names" {
  description = "The name tags of the route tables for private subnets"
  value       = [for r in aws_route_table.private_route_table : r.tags["Name"]]
}
