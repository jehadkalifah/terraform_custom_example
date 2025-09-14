# Common Tag Variables
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

# aws_vpc.main Variables
variable "cidr_block" {
  type                        = string
  description                 = "This is a variable of CIDR block"
}

# aws_subnet.vpc_subnets Variables
variable "vpc_subnets_config" {
  description = "Map of subnets with AZ, CIDR, and type"
  type = map(object({
    cidr_block = string
    az         = string
    type       = string
  }))
}

# aws_network_acl_rule.vpc_acl_public_inbound_rules Variables
variable "vpc_acl_public_inbound_rule_config" {
  description = "NACL public inbound rule settings"  
  type = map(object({
    rule_number    = number
    protocol       = string
    rule_action    = string
    cidr_block     = string
    from_port      = number
    to_port        = number
  }))
}

# aws_network_acl_rule.vpc_acl_public_outbound_rules Variables
variable "vpc_acl_public_outbound_rule_config" {
  description = "NACL public outbound rule settings"  
  type = map(object({
    rule_number    = number
    protocol       = string
    rule_action    = string
    cidr_block     = string
    from_port      = number
    to_port        = number
  }))
}

# aws_network_acl_rule.vpc_acl_web_inbound_rules Variables
variable "vpc_acl_web_inbound_rule_config" {
  description = "NACL web inbound rule settings"  
  type = map(object({
    rule_number    = number
    protocol       = string
    rule_action    = string
    cidr_block     = string
    from_port      = number
    to_port        = number
  }))
}

# aws_network_acl_rule.vpc_acl_web_outbound_rules Variables
variable "vpc_acl_web_outbound_rule_config" {
  description = "NACL web outbound rule settings"  
  type = map(object({
    rule_number    = number
    protocol       = string
    rule_action    = string
    cidr_block     = string
    from_port      = number
    to_port        = number
  }))
}

# aws_network_acl_rule.vpc_acl_app_inbound_rules Variables
variable "vpc_acl_app_inbound_rule_config" {
  description = "NACL app inbound rule settings"  
  type = map(object({
    rule_number    = number
    protocol       = string
    rule_action    = string
    cidr_block     = string
    from_port      = number
    to_port        = number
  }))
}

# aws_network_acl_rule.vpc_acl_app_outbound_rules Variables
variable "vpc_acl_app_outbound_rule_config" {
  description = "NACL app outbound rule settings"  
  type = map(object({
    rule_number    = number
    protocol       = string
    rule_action    = string
    cidr_block     = string
    from_port      = number
    to_port        = number
  }))
}

# aws_network_acl_rule.vpc_acl_data_inbound_rules Variables
variable "vpc_acl_data_inbound_rule_config" {
  description = "NACL data inbound rule settings"  
  type = map(object({
    rule_number    = number
    protocol       = string
    rule_action    = string
    cidr_block     = string
    from_port      = number
    to_port        = number
  }))
}

# aws_network_acl_rule.vpc_acl_data_outbound_rules Variables
variable "vpc_acl_data_outbound_rule_config" {
  description = "NACL data outbound rule settings"  
  type = map(object({
    rule_number    = number
    protocol       = string
    rule_action    = string
    cidr_block     = string
    from_port      = number
    to_port        = number
  }))
}

# aws_security_group_rule.vpc_sg_public_inbound_rules Variables
variable "vpc_sg_public_inbound_rule_config" {
  description = "Security group public inbound rule settings"  
  type = map(object({
    Name           = string
    description    = string
    ip_protocol    = string
    cidr_ipv4      = string
    from_port      = number
    to_port        = number
  }))
}

# aws_vpc_security_group_egress_rule.vpc_sg_public_outbound_rules Variables
variable "vpc_sg_public_outbound_rule_config" {
  description = "Security group public outbound rule settings"  
  type = map(object({
    Name           = string
    description    = string
    ip_protocol    = string
    cidr_ipv4      = string
    from_port      = number
    to_port        = number
  }))
}

# aws_security_group_rule.vpc_sg_web_inbound_rules Variables
variable "vpc_sg_web_inbound_rule_config" {
  description = "Security group web inbound rule settings"  
  type = map(object({
    Name           = string
    description    = string
    ip_protocol    = string
    cidr_ipv4      = string
    from_port      = number
    to_port        = number
  }))
}

# aws_vpc_security_group_egress_rule.vpc_sg_web_outbound_rules Variables
variable "vpc_sg_web_outbound_rule_config" {
  description = "Security group web outbound rule settings"  
  type = map(object({
    Name           = string
    description    = string
    ip_protocol    = string
    cidr_ipv4      = string
    from_port      = number
    to_port        = number
  }))
}

# aws_security_group_rule.vpc_sg_app_inbound_rules Variables
variable "vpc_sg_app_inbound_rule_config" {
  description = "Security group app inbound rule settings"  
  type = map(object({
    Name           = string
    description    = string
    ip_protocol    = string
    cidr_ipv4      = string
    from_port      = number
    to_port        = number
  }))
}

# aws_vpc_security_group_egress_rule.vpc_sg_app_outbound_rules Variables
variable "vpc_sg_app_outbound_rule_config" {
  description = "Security group app outbound rule settings"  
  type = map(object({
    Name           = string
    description    = string
    ip_protocol    = string
    cidr_ipv4      = string
    from_port      = number
    to_port        = number
  }))
}

# aws_security_group_rule.vpc_sg_data_inbound_rules Variables
variable "vpc_sg_data_inbound_rule_config" {
  description = "Security group data inbound rule settings"  
  type = map(object({
    Name           = string
    description    = string
    ip_protocol    = string
    cidr_ipv4      = string
    from_port      = number
    to_port        = number
  }))
}

# aws_vpc_security_group_egress_rule.vpc_sg_data_outbound_rules Variables
variable "vpc_sg_data_outbound_rule_config" {
  description = "Security group data outbound rule settings"  
  type = map(object({
    Name           = string
    description    = string
    ip_protocol    = string
    cidr_ipv4      = string
    from_port      = number
    to_port        = number
  }))
}

# aws_route_table.vpc_rt Variables
variable "vpc_rt_route_config" {
  description = "Route table route settings"  
  type = map(object({ 
    route_table          = string
    cidr_block           = optional(string)
    ipv6_cidr_block      = optional(string)
    gateway              = optional(bool)
    nat_gateway          = optional(bool)
    nat_gwy_az           = optional(number)
  }))
}










