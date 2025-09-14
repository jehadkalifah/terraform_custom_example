################
## VPC MODULE ##
################

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


################
## ASG MODULE ##
################

/*
###########################################
Description of Auto Scaling Group Variables
###########################################

std_name = "Standard name of Auto Scaling Group module"
lb_sg_name = "Name of Security Group should be used"
lb_internal = "Make ALB under Internal network only"
lb_tg_port = "Port on which targets receive traffic"
lb_tg_protocol = "Protocol to use for routing traffic to the targets"
lb_tg_target_type = "Type of target that you must specify when registering targets with this target group"
lb_tg_health_check_protocol = "Protocol the load balancer uses when performing health checks on targets"
lb_tg_health_check_port = "The port the load balancer uses when performing health checks on targets"
lb_tg_health_check_path = "Destination for the health check request"
lb_tg_health_check_healthy_threshold = "Number of consecutive health check successes required before considering a target healthy"
lb_tg_health_check_unhealthy_threshold = "Number of consecutive health check failures required before considering a target unhealthy"
lb_tg_health_check_timeout = "Amount of time, in seconds, during which no response from a target means a failed health check"
lb_tg_health_check_interval = "Approximate amount of time, in seconds, between health checks of an individual target"
lb_tg_health_check_matcher = "The HTTP or gRPC codes to use when checking for a successful response from a target"
lb_tg_listener_port = "Port on which the load balancer is listening"
lb_tg_listener_protocol = "Protocol for connections from clients to the load balancer"
temp_ec2_ami_id = "The AMI from which to launch the instance"
temp_instance_type = "The type of the instance"
temp_user_data_base64_file = "The base64-encoded user data to provide when launching the instance"
temp_key_pair_name = "Name of AWS key pair was created"
tmp_ebs_block_devices = "List of block device mappings for launch template"
asg_min_size = "Minimum size of the Auto Scaling Group"
asg_max_size = "Maximum size of the Auto Scaling Group"
asg_desired_capacity = "Number of Amazon EC2 instances that should be running in the group"
asg_health_check_grace_period = "Time (in seconds) after instance comes into service before checking health"
asg_health_check_type = "Controls how health checking is done"
asg_policy_name = "Name of the policy"
asg_policy_type = "Name of the policy"
asg_policy_metric_type = "Metric type"
asg_policy_target_value = "Target value for the metric"
*/

variable "asg_configs" {
  description = "Map of configurations for each ASG module"
  type = map(object({
    std_name                                    = string
    lb_sg_name                                  = string
    lb_internal                                 = bool
    lb_tg_port                                  = number
    lb_tg_protocol                              = string
    lb_tg_target_type                           = string
    lb_tg_health_check_protocol                 = string
    lb_tg_health_check_port                     = number
    lb_tg_health_check_path                     = string
    lb_tg_health_check_healthy_threshold        = number
    lb_tg_health_check_unhealthy_threshold      = number
    lb_tg_health_check_timeout                  = number
    lb_tg_health_check_interval                 = number
    lb_tg_health_check_matcher                  = string
    lb_tg_listener_port                         = number
    lb_tg_listener_protocol                     = string
    temp_ec2_ami_id                             = string
    temp_instance_type                          = string
    temp_user_data_base64_file                  = string
    temp_key_pair_name                          = string
    tmp_ebs_block_devices                       = list(object({
                                                    device_name           = string
                                                    volume_size           = number
                                                    volume_type           = string
                                                    delete_on_termination = bool
                                                    encrypted             = bool
                                                  }))
    asg_min_size                                = number 
    asg_max_size                                = number
    asg_desired_capacity                        = number
    asg_health_check_grace_period               = number
    asg_health_check_type                       = string
    asg_policy_name                             = string
    asg_policy_type                             = string
    asg_policy_metric_type                      = string
    asg_policy_target_value                     = number
  }))
}
