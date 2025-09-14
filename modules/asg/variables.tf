# Common Tag Variables
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "std_name" {
   description = "Standard name of Auto Scaling Group module"
   type        = string
}

# aws_lb.asg_app_lb Variables
variable "lb_sg_ids" {
   description = "List of security group IDs to assign to the LB"
   type        = list(string)
}

variable "lb_subnet_ids" { 
   description = "List of subnet IDs to launch resources in\nSubnets automatically determine which availability zones the group will reside"
   type = list(string) 
}

variable "lb_internal" {
   description = "Make ALB under Internal network only"
   type        = bool
}

# aws_lb_target_group.asg_lb_target_group Variables
variable "lb_tg_port" {
   description = "Port on which targets receive traffic"
   type        = number
}

variable "lb_tg_protocol" {
   description = "Protocol to use for routing traffic to the targets"
   type        = string
}

variable "lb_tg_vpc_id" {
   description = "Identifier of the VPC in which to create the target group"
   type        = string
}

variable "lb_tg_target_type" {
   description = "Type of target that you must specify when registering targets with this target group"
   type        = string
}

variable "lb_tg_health_check_protocol" {
   description = "Protocol the load balancer uses when performing health checks on targets"
   type        = string
}

variable "lb_tg_health_check_port" {
   description = "The port the load balancer uses when performing health checks on targets"
   type        = number
}

variable "lb_tg_health_check_path" {
   description = "Destination for the health check request"
   type        = string
}

variable "lb_tg_health_check_healthy_threshold" {
   description = "Number of consecutive health check successes required before considering a target healthy"
   type        = number
}

variable "lb_tg_health_check_unhealthy_threshold" {
   description = "Number of consecutive health check failures required before considering a target unhealthy"
   type        = number
}

variable "lb_tg_health_check_timeout" {
   description = "Amount of time, in seconds, during which no response from a target means a failed health check"
   type        = number
}

variable "lb_tg_health_check_interval" {
   description = "Approximate amount of time, in seconds, between health checks of an individual target"
   type        = number
}

variable "lb_tg_health_check_matcher" {
   description = "The HTTP or gRPC codes to use when checking for a successful response from a target"
   type        = string
}

# aws_lb_listener.asg_lb_listener Variables
variable "lb_tg_listener_port" {
   description = "Port on which the load balancer is listening"
   type        = number
}

variable "lb_tg_listener_protocol" {
   description = "Protocol for connections from clients to the load balancer"
   type        = string
}

# aws_launch_template.asg_ec2_template Variables
variable "temp_ec2_ami_id" {
   description = "The AMI from which to launch the instance"
   type        = string
}

variable "temp_instance_type" {
   description = "The type of the instance"
   type        = string
}

variable "temp_user_data_base64_file" {
   description = "The base64-encoded user data to provide when launching the instance"
   type        = string
}

variable "temp_key_pair_name" {
   description = "Name of AWS key pair was created"
   type        = string
}

variable "temp_sg_ids" {
   description = "A list of security group IDs to associate with"
   type        = list(string)
}

variable "tmp_ebs_block_devices" {
   description = "List of block device mappings for launch template"
   type = list(object({
    device_name           = string
    volume_size           = number
    volume_type           = string
    delete_on_termination = bool
    encrypted             = bool
  }))
}

# aws_autoscaling_group.asg_group Variables
variable "asg_min_size" {
   description = "Minimum size of the Auto Scaling Group"
   type        = number 
   default = 1 
}

variable "asg_max_size" { 
   description = "Maximum size of the Auto Scaling Group"
   type        = number
   default = 3 
}

variable "asg_desired_capacity" { 
   description = "Number of Amazon EC2 instances that should be running in the group"
   type        = number
   default = 2 
}

variable "asg_health_check_grace_period" { 
   description = "Time (in seconds) after instance comes into service before checking health"
   type        = number
   default = 300 
}

variable "asg_health_check_type" { 
   description = "Controls how health checking is done"
   type        = string
   default = "EC2" 
}

variable "asg_vpc_zone_identifier" { 
   description = "List of subnet IDs to launch resources in. \nSubnets automatically determine which availability zones the group will reside"
   type        = list(string)
}

# aws_autoscaling_policy.asg_cpu_policy Variables
variable "asg_policy_name" { 
   description = "Name of the policy"
   type        = string
}

variable "asg_policy_type" { 
   description = "Name of the policy"
   type        = string
}

variable "asg_policy_metric_type" { 
   description = "Metric type"
   type        = string
}

variable "asg_policy_target_value" { 
   description = "Target value for the metric"
   type        = number
}
