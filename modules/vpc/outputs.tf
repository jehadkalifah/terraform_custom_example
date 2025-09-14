# Output Security Group IDs
output "output_vpc_sg_ids" {
  value = { 
    public = aws_security_group.vpc_sg["public"].id
    web = aws_security_group.vpc_sg["web"].id
    app = aws_security_group.vpc_sg["app"].id
    data = aws_security_group.vpc_sg["data"].id
  }
}

# Output VPC Subnets IDs
output "output_vpc_subnet_ids" {
  value = local.subnet_groups
}

# Output VPC ID
output "output_vpc_id" {
  value = aws_vpc.main.id
}
