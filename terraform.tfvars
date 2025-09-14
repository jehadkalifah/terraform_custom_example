######################
## COMMON VARIABLES ##
######################

# Common Tag Variables
common_tags = { Terraform       = "True"
                Environment     = "Production"
                Owner           = "DevOps Team"  
              }


################
## VPC MODULE ##
################

# aws_vpc.main Variables
cidr_block = "10.0.0.0/16"

# aws_subnet.vpc_subnets Variables
vpc_subnets_config = {  
                      "public-subnet-01" = { cidr_block = "10.0.0.0/20", az = "eu-west-1a", type = "public" }
                      "public-subnet-02" = { cidr_block = "10.0.16.0/20", az = "eu-west-1b", type = "public" }
                      "public-subnet-03" = { cidr_block = "10.0.32.0/20", az = "eu-west-1c", type = "public" }

                      "web-subnet-01" = { cidr_block = "10.0.64.0/20", az = "eu-west-1a", type = "web" }
                      "web-subnet-02" = { cidr_block = "10.0.80.0/20", az = "eu-west-1b", type = "web" }
                      "web-subnet-03" = { cidr_block = "10.0.96.0/20", az = "eu-west-1c", type = "web" }

                      "app-subnet-01" = { cidr_block = "10.0.128.0/20", az = "eu-west-1a", type = "app" }
                      "app-subnet-02" = { cidr_block = "10.0.144.0/20", az = "eu-west-1b", type = "app" }
                      "app-subnet-03" = { cidr_block = "10.0.160.0/20", az = "eu-west-1c", type = "app" }

                      "data-subnet-01" = { cidr_block = "10.0.192.0/20", az = "eu-west-1a", type = "data" }
                      "data-subnet-02" = { cidr_block = "10.0.208.0/20", az = "eu-west-1b", type = "data" }
                      "data-subnet-03" = { cidr_block = "10.0.224.0/20", az = "eu-west-1c", type = "data" }
                     }

# aws_network_acl_rule.vpc_acl_public_inbound_rules Variables
vpc_acl_public_inbound_rule_config = { 
    "https_rule" = { rule_number = 100, protocol = "tcp", rule_action = "allow", cidr_block = "0.0.0.0/0", from_port = 443, to_port = 443}                                     
    "ephemeral_rule" = { rule_number = 101, protocol = "tcp", rule_action = "allow", cidr_block = "0.0.0.0/0", from_port = 1024, to_port = 65535}                                     
}     

# aws_network_acl_rule.vpc_acl_public_inbound_rules Variables
vpc_acl_public_outbound_rule_config = { 
    "allow_all_rule" = { rule_number = 100, protocol = "-1", rule_action = "allow", cidr_block = "0.0.0.0/0", from_port = 0, to_port = 0}                                     
}  

# aws_network_acl_rule.vpc_acl_web_inbound_rules Variables
vpc_acl_web_inbound_rule_config = { 
    "https_rule" = { rule_number = 100, protocol = "tcp", rule_action = "allow", cidr_block = "0.0.0.0/0", from_port = 443, to_port = 443}                                     
    "ephemeral_rule" = { rule_number = 101, protocol = "tcp", rule_action = "allow", cidr_block = "0.0.0.0/0", from_port = 1024, to_port = 65535}                                     
}     

# aws_network_acl_rule.vpc_acl_web_inbound_rules Variables
vpc_acl_web_outbound_rule_config = { 
    "allow_all_rule" = { rule_number = 100, protocol = "-1", rule_action = "allow", cidr_block = "0.0.0.0/0", from_port = 0, to_port = 0}                                     
}

# aws_network_acl_rule.vpc_acl_app_inbound_rules Variables
vpc_acl_app_inbound_rule_config = { 
    "https_rule" = { rule_number = 100, protocol = "tcp", rule_action = "allow", cidr_block = "0.0.0.0/0", from_port = 443, to_port = 443}                                     
    "ephemeral_rule" = { rule_number = 101, protocol = "tcp", rule_action = "allow", cidr_block = "0.0.0.0/0", from_port = 1024, to_port = 65535}                                     
}     

# aws_network_acl_rule.vpc_acl_app_inbound_rules Variables
vpc_acl_app_outbound_rule_config = { 
    "allow_all_rule" = { rule_number = 100, protocol = "-1", rule_action = "allow", cidr_block = "0.0.0.0/0", from_port = 0, to_port = 0}                                     
}

# aws_network_acl_rule.vpc_acl_data_inbound_rules Variables
vpc_acl_data_inbound_rule_config = { 
    "https_rule" = { rule_number = 100, protocol = "tcp", rule_action = "allow", cidr_block = "0.0.0.0/0", from_port = 443, to_port = 443}                                     
    "ephemeral_rule" = { rule_number = 101, protocol = "tcp", rule_action = "allow", cidr_block = "0.0.0.0/0", from_port = 1024, to_port = 65535}                                     
}     

# aws_network_acl_rule.vpc_acl_data_inbound_rules Variables
vpc_acl_data_outbound_rule_config = { 
    "allow_all_rule" = { rule_number = 100, protocol = "-1", rule_action = "allow", cidr_block = "0.0.0.0/0", from_port = 0, to_port = 0}                                     
}

# aws_security_group_rule.vpc_sg_public_inbound_rules Variables
vpc_sg_public_inbound_rule_config = { 
    "https_rule" = { Name = "https", description = "Allow HTTPS", ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0", from_port = 443, to_port = 443}                                     
    "ephemeral_rule" = { Name = "ephemeral", description = "Allow ephemeral ports", ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0", from_port = 1024, to_port = 65535}                                     
}  

# aws_vpc_security_group_egress_rule.vpc_sg_public_outbound_rules Variables
vpc_sg_public_outbound_rule_config = { 
    "allow_all_rule" = { Name = "Allow all traffics", description = "Allow outbound all traffics", ip_protocol = "-1", cidr_ipv4 = "0.0.0.0/0", from_port = 0, to_port = 0}                                     
}  

# aws_security_group_rule.vpc_sg_web_inbound_rules Variables
vpc_sg_web_inbound_rule_config = { 
    "https_rule" = { Name = "https", description = "Allow HTTPS", ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0", from_port = 443, to_port = 443}                                     
    "ephemeral_rule" = { Name = "ephemeral", description = "Allow ephemeral ports", ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0", from_port = 1024, to_port = 65535}                                     
}  

# aws_vpc_security_group_egress_rule.vpc_sg_web_outbound_rules Variables
vpc_sg_web_outbound_rule_config = { 
    "allow_all_rule" = { Name = "Allow all traffics", description = "Allow outbound all traffics", ip_protocol = "-1", cidr_ipv4 = "0.0.0.0/0", from_port = 0, to_port = 0}                                     
}                       

# aws_security_group_rule.vpc_sg_app_inbound_rules Variables
vpc_sg_app_inbound_rule_config = { 
    "https_rule" = { Name = "https", description = "Allow HTTPS", ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0", from_port = 443, to_port = 443}                                     
    "ephemeral_rule" = { Name = "ephemeral", description = "Allow ephemeral ports", ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0", from_port = 1024, to_port = 65535}                                     
}  

# aws_vpc_security_group_egress_rule.vpc_sg_app_outbound_rules Variables
vpc_sg_app_outbound_rule_config = { 
    "allow_all_rule" = { Name = "Allow all traffics", description = "Allow outbound all traffics", ip_protocol = "-1", cidr_ipv4 = "0.0.0.0/0", from_port = 0, to_port = 0}                                     
}                       

# aws_security_group_rule.vpc_sg_data_inbound_rules Variables
vpc_sg_data_inbound_rule_config = { 
    "https_rule" = { Name = "https", description = "Allow HTTPS", ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0", from_port = 443, to_port = 443}                                     
    "ephemeral_rule" = { Name = "ephemeral", description = "Allow ephemeral ports", ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0", from_port = 1024, to_port = 65535}                                     
}  

# aws_vpc_security_group_egress_rule.vpc_sg_data_outbound_rules Variables
vpc_sg_data_outbound_rule_config = { 
    "allow_all_rule" = { Name = "Allow all traffics", description = "Allow outbound all traffics", ip_protocol = "-1", cidr_ipv4 = "0.0.0.0/0", from_port = 0, to_port = 0}                                     
}                       

# aws_route_table.vpc_rt Variables
vpc_rt_route_config = { 
    public_route01 = { route_table = "public-subnet-01", cidr_block = "0.0.0.0/0", gateway = true }
    public_route02 = { route_table = "public-subnet-01", cidr_block = "13.32.0.0/15", gateway = true }
    public_route03 = { route_table = "public-subnet-02", cidr_block = "0.0.0.0/0", gateway = true }
    
    # 0: public_nat_gwy_1, 1: public_nat_gwy_2, 2: public_nat_gwy_3
    # web_route01 = { route_table = "web-subnet-01", nat_gwy_az = 0, nat_gateway = true, cidr_block = "0.0.0.0/0" }
    # web_route02 = { route_table = "web-subnet-02", nat_gwy_az = 1, nat_gateway = true, cidr_block = "0.0.0.0/0" }
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

asg_configs = {
  asg_web = {
            std_name                                 = "web"
            lb_sg_name                               = "web"
            lb_internal                              = true
            lb_tg_port                               = 80
            lb_tg_protocol                           = "HTTP"
            lb_tg_target_type                        = "instance"
            lb_tg_health_check_protocol              = "HTTP"
            lb_tg_health_check_port                  = 80
            lb_tg_health_check_path                  = "/"
            lb_tg_health_check_healthy_threshold     = 3
            lb_tg_health_check_unhealthy_threshold   = 2
            lb_tg_health_check_timeout               = 5
            lb_tg_health_check_interval              = 10
            lb_tg_health_check_matcher               = "200-299"
            lb_tg_listener_port                      = 80
            lb_tg_listener_protocol                  = "HTTP"

            temp_ec2_ami_id                          = "ami-0dc0ac921efee9f9d"
            temp_instance_type                       = "t3.micro"
            temp_user_data_base64_file               = "user_data.sh"
            temp_key_pair_name                       = "my_ec2_key"
            tmp_ebs_block_devices                    = [ 
                                                        {device_name= "/dev/sda1", volume_size = 8, volume_type = "standard", delete_on_termination = true, encrypted = true},
                                                        {device_name= "/dev/sdb", volume_size = 8, volume_type = "standard", delete_on_termination = false, encrypted = true}
                                                       ]

            asg_min_size                             = 1
            asg_max_size                             = 3
            asg_desired_capacity                     = 2
            asg_health_check_grace_period            = 300
            asg_health_check_type                    = "EC2"
            asg_policy_name                          = "asg-cpu-scale-policy"
            asg_policy_type                          = "TargetTrackingScaling"
            asg_policy_metric_type                   = "ASGAverageCPUUtilization"
            asg_policy_target_value                  = 80
  },
  asg_app = {
            std_name                                 = "app"
            lb_sg_name                               = "app"
            lb_internal                              = true
            lb_tg_port                               = 80
            lb_tg_protocol                           = "HTTP"
            lb_tg_target_type                        = "instance"
            lb_tg_health_check_protocol              = "HTTP"
            lb_tg_health_check_port                  = 80
            lb_tg_health_check_path                  = "/"
            lb_tg_health_check_healthy_threshold     = 3
            lb_tg_health_check_unhealthy_threshold   = 2
            lb_tg_health_check_timeout               = 5
            lb_tg_health_check_interval              = 10
            lb_tg_health_check_matcher               = "200-299"
            lb_tg_listener_port                      = 80
            lb_tg_listener_protocol                  = "HTTP"

            temp_ec2_ami_id                          = "ami-0dc0ac921efee9f9d"
            temp_instance_type                       = "t3.micro"
            temp_user_data_base64_file               = "user_data.sh"
            temp_key_pair_name                       = "my_ec2_key"
            tmp_ebs_block_devices                    = [ 
                                                        {device_name= "/dev/sda1", volume_size = 8, volume_type = "standard", delete_on_termination = true, encrypted = true},
                                                        {device_name= "/dev/sdb", volume_size = 8, volume_type = "standard", delete_on_termination = false, encrypted = true}
                                                       ]

            asg_min_size                             = 1
            asg_max_size                             = 3
            asg_desired_capacity                     = 2
            asg_health_check_grace_period            = 300
            asg_health_check_type                    = "EC2"
            asg_policy_name                          = "asg-cpu-scale-policy"
            asg_policy_type                          = "TargetTrackingScaling"
            asg_policy_metric_type                   = "ASGAverageCPUUtilization"
            asg_policy_target_value                  = 80
  }
}

