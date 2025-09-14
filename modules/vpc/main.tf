# Local Values
locals {
  # Include all public subnet ids
  public_subnet_ids = [
    for key, value in var.vpc_subnets_config :
    aws_subnet.vpc_subnets[key].id if value.type == "public"
  ]

  # Include all web subnet ids
  web_subnet_ids = [
    for key, value in var.vpc_subnets_config :
    aws_subnet.vpc_subnets[key].id if value.type == "web"
  ]

  # Include all app subnet ids
  app_subnet_ids = [
    for key, value in var.vpc_subnets_config :
    aws_subnet.vpc_subnets[key].id if value.type == "app"
  ]

  # Include all data subnet ids
  data_subnet_ids = [
    for key, value in var.vpc_subnets_config :
    aws_subnet.vpc_subnets[key].id if value.type == "data"
  ]    

  # Include all subnet ids in one group
  subnet_groups = {
    public = local.public_subnet_ids
    web    = local.web_subnet_ids
    app    = local.app_subnet_ids
    data   = local.data_subnet_ids
  }
}


# Create VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
                
  tags = {
    Name         = "Main VPC"
    Terraform    = var.common_tags["Terraform"]
    Environment  = var.common_tags["Environment"]
    Owner        = var.common_tags["Owner"]
  }
}


# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name         = "Main VPC IGW"
    Terraform    = var.common_tags["Terraform"]
    Environment  = var.common_tags["Environment"]
    Owner        = var.common_tags["Owner"]
  }
}


# Create VPC Subnets
resource "aws_subnet" "vpc_subnets" {
  for_each = var.vpc_subnets_config

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.type == "public" ? true : false

  tags = {
    Name = each.key
    Type = each.value.type
    Terraform = var.common_tags["Terraform"]
    Environment = var.common_tags["Environment"]
    Owner = var.common_tags["Owner"]
  }
}


# Create NACL per Segment with Acl Association and Rules
resource "aws_network_acl" "vpc_nacl" {
  for_each = local.subnet_groups
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${each.key}-nacl"
    Terraform = var.common_tags["Terraform"]
    Environment = var.common_tags["Environment"]
    Owner = var.common_tags["Owner"]
  }
}

resource "aws_network_acl_association" "vpc_nacl_public_asso" {
  count = length(local.public_subnet_ids)
  subnet_id      = local.public_subnet_ids[count.index]
  network_acl_id = aws_network_acl.vpc_nacl["public"].id
}

resource "aws_network_acl_association" "vpc_nacl_web_asso" {
  count = length(local.web_subnet_ids)
  subnet_id      = local.web_subnet_ids[count.index]
  network_acl_id = aws_network_acl.vpc_nacl["web"].id
}

resource "aws_network_acl_association" "vpc_nacl_app_asso" {
  count = length(local.app_subnet_ids)
  subnet_id      = local.app_subnet_ids[count.index]
  network_acl_id = aws_network_acl.vpc_nacl["app"].id
}

resource "aws_network_acl_association" "vpc_nacl_data_asso" {
  count = length(local.data_subnet_ids)
  subnet_id      = local.data_subnet_ids[count.index]
  network_acl_id = aws_network_acl.vpc_nacl["data"].id
}

resource "aws_network_acl_rule" "vpc_acl_public_inbound_rules" {
  for_each       = var.vpc_acl_public_inbound_rule_config
  network_acl_id = aws_network_acl.vpc_nacl["public"].id
  rule_number    = each.value.rule_number
  egress         = false
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}

resource "aws_network_acl_rule" "vpc_acl_public_outbound_rules" {
  for_each       = var.vpc_acl_public_outbound_rule_config
  network_acl_id = aws_network_acl.vpc_nacl["public"].id
  rule_number    = each.value.rule_number
  egress         = true
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}

resource "aws_network_acl_rule" "vpc_acl_web_inbound_rules" {
  for_each       = var.vpc_acl_web_inbound_rule_config
  network_acl_id = aws_network_acl.vpc_nacl["web"].id
  rule_number    = each.value.rule_number
  egress         = false
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}

resource "aws_network_acl_rule" "vpc_acl_web_outbound_rules" {
  for_each       = var.vpc_acl_web_outbound_rule_config
  network_acl_id = aws_network_acl.vpc_nacl["web"].id
  rule_number    = each.value.rule_number
  egress         = true
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}

resource "aws_network_acl_rule" "vpc_acl_app_inbound_rules" {
  for_each       = var.vpc_acl_app_inbound_rule_config
  network_acl_id = aws_network_acl.vpc_nacl["app"].id
  rule_number    = each.value.rule_number
  egress         = false
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}

resource "aws_network_acl_rule" "vpc_acl_app_outbound_rules" {
  for_each       = var.vpc_acl_app_outbound_rule_config
  network_acl_id = aws_network_acl.vpc_nacl["app"].id
  rule_number    = each.value.rule_number
  egress         = true
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}

resource "aws_network_acl_rule" "vpc_acl_data_inbound_rules" {
  for_each       = var.vpc_acl_data_inbound_rule_config
  network_acl_id = aws_network_acl.vpc_nacl["data"].id
  rule_number    = each.value.rule_number
  egress         = false
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}

resource "aws_network_acl_rule" "vpc_acl_data_outbound_rules" {
  for_each       = var.vpc_acl_data_outbound_rule_config
  network_acl_id = aws_network_acl.vpc_nacl["data"].id
  rule_number    = each.value.rule_number
  egress         = true
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}


# Create Security Groups per Segment and Rules
resource "aws_security_group" "vpc_sg" {
  for_each = local.subnet_groups
  name        = "${each.key}-sg"
  description = "Security group for ${each.key} subnet group"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${each.key}-sg"
    Terraform = var.common_tags["Terraform"]
    Environment = var.common_tags["Environment"]
    Owner = var.common_tags["Owner"]
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpc_sg_public_inbound_rules" {
  for_each = var.vpc_sg_public_inbound_rule_config
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.ip_protocol
  cidr_ipv4         = each.value.cidr_ipv4
  description       = each.value.description
  security_group_id = aws_security_group.vpc_sg["public"].id
  tags = { Name = each.value.Name }
}

resource "aws_vpc_security_group_egress_rule" "vpc_sg_public_outbound_rules" {
  for_each = var.vpc_sg_public_outbound_rule_config
  from_port         = each.value.ip_protocol == "-1" ? null : each.value.from_port
  to_port           = each.value.ip_protocol == "-1" ? null : each.value.to_port  
  ip_protocol       = each.value.ip_protocol
  cidr_ipv4         = each.value.cidr_ipv4
  description       = each.value.description
  security_group_id = aws_security_group.vpc_sg["public"].id
  tags = { Name = each.value.Name }
}

resource "aws_vpc_security_group_ingress_rule" "vpc_sg_web_inbound_rules" {
  for_each = var.vpc_sg_web_inbound_rule_config
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.ip_protocol
  cidr_ipv4         = each.value.cidr_ipv4
  description       = each.value.description
  security_group_id = aws_security_group.vpc_sg["web"].id
  tags = { Name = each.value.Name }
}

resource "aws_vpc_security_group_egress_rule" "vpc_sg_web_outbound_rules" {
  for_each = var.vpc_sg_web_outbound_rule_config
  from_port         = each.value.ip_protocol == "-1" ? null : each.value.from_port
  to_port           = each.value.ip_protocol == "-1" ? null : each.value.to_port  
  ip_protocol       = each.value.ip_protocol
  cidr_ipv4         = each.value.cidr_ipv4
  description       = each.value.description
  security_group_id = aws_security_group.vpc_sg["web"].id
  tags = { Name = each.value.Name }
}

resource "aws_vpc_security_group_ingress_rule" "vpc_sg_app_inbound_rules" {
  for_each = var.vpc_sg_app_inbound_rule_config
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.ip_protocol
  cidr_ipv4         = each.value.cidr_ipv4
  description       = each.value.description
  security_group_id = aws_security_group.vpc_sg["app"].id
  tags = { Name = each.value.Name }
}

resource "aws_vpc_security_group_egress_rule" "vpc_sg_app_outbound_rules" {
  for_each = var.vpc_sg_app_outbound_rule_config
  from_port         = each.value.ip_protocol == "-1" ? null : each.value.from_port
  to_port           = each.value.ip_protocol == "-1" ? null : each.value.to_port  
  ip_protocol       = each.value.ip_protocol
  cidr_ipv4         = each.value.cidr_ipv4
  description       = each.value.description
  security_group_id = aws_security_group.vpc_sg["app"].id
  tags = { Name = each.value.Name }
}

resource "aws_vpc_security_group_ingress_rule" "vpc_sg_data_inbound_rules" {
  for_each = var.vpc_sg_data_inbound_rule_config
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.ip_protocol
  cidr_ipv4         = each.value.cidr_ipv4
  description       = each.value.description
  security_group_id = aws_security_group.vpc_sg["data"].id
  tags = { Name = each.value.Name }
}

resource "aws_vpc_security_group_egress_rule" "vpc_sg_data_outbound_rules" {
  for_each = var.vpc_sg_data_outbound_rule_config
  from_port         = each.value.ip_protocol == "-1" ? null : each.value.from_port
  to_port           = each.value.ip_protocol == "-1" ? null : each.value.to_port  
  ip_protocol       = each.value.ip_protocol
  cidr_ipv4         = each.value.cidr_ipv4
  description       = each.value.description
  security_group_id = aws_security_group.vpc_sg["data"].id
  tags = { Name = each.value.Name }
}


# Create Route Table per Subnet with Association and Routes
resource "aws_route_table" "vpc_rt" {
  for_each = aws_subnet.vpc_subnets
  vpc_id = aws_vpc.main.id
  route = []
  tags = {
    Name = "${each.key}-rt"
    Terraform = var.common_tags["Terraform"]
    Environment = var.common_tags["Environment"]
    Owner = var.common_tags["Owner"]
  }
  lifecycle { ignore_changes = [route] }
}

resource "aws_route_table_association" "vpc_rt_assoc" {
  for_each = aws_subnet.vpc_subnets
  subnet_id      = aws_subnet.vpc_subnets[each.key].id
  route_table_id = aws_route_table.vpc_rt[each.key].id
}

resource "aws_route" "vpc_rt_route" {
  for_each = var.vpc_rt_route_config
  route_table_id                = aws_route_table.vpc_rt[each.value.route_table].id
  destination_cidr_block        = lookup(each.value, "cidr_block", null)
  destination_ipv6_cidr_block   = lookup(each.value, "ipv6_cidr_block", null)
  gateway_id                    = lookup(each.value, "gateway") == true ? aws_internet_gateway.igw.id : null
  nat_gateway_id                = lookup(each.value, "nat_gateway") == true ? aws_nat_gateway.vpc_public_nat_gwy[each.value.nat_gwy_az].id : null
}


# Create NAT Gateway per AZ and its Elastic IP
resource "aws_eip" "vpc_public_nat_eips" {
  count = length(local.public_subnet_ids)
  domain   = "vpc"

  tags = {
    Name = "public_nat_eip_${count.index + 1}"
    Terraform = var.common_tags["Terraform"]
    Environment = var.common_tags["Environment"]
    Owner = var.common_tags["Owner"]
  }
  depends_on = [ aws_vpc.main, aws_subnet.vpc_subnets ]
}

resource "aws_nat_gateway" "vpc_public_nat_gwy" {
  count = length(local.public_subnet_ids)
  subnet_id     = local.public_subnet_ids[count.index]
  allocation_id = aws_eip.vpc_public_nat_eips[count.index].id

  tags = {
    Name = "public_nat_gwy_${count.index + 1}"
    Terraform = var.common_tags["Terraform"]
    Environment = var.common_tags["Environment"]
    Owner = var.common_tags["Owner"]
  }
}
