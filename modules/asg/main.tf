# Create ALB, Target Group and Listener for Auto Scaling Group
resource "aws_lb" "asg_app_lb" {
  name               = "asg-${var.std_name}-lb"
  load_balancer_type = "application"  
  security_groups    = var.lb_sg_ids
  subnets            = var.lb_subnet_ids
  internal           = var.lb_internal

  tags = {
    Name = "asg-${var.std_name}-lb"
    Terraform    = var.common_tags["Terraform"]
    Environment  = var.common_tags["Environment"]
    Owner        = var.common_tags["Owner"]
  }
}

resource "aws_lb_target_group" "asg_lb_target_group" {
  name        = "asg-${var.std_name}-lb-target-group"
  port        = var.lb_tg_port
  protocol    = var.lb_tg_protocol
  vpc_id      = var.lb_tg_vpc_id
  target_type = var.lb_tg_target_type 

  health_check {
    protocol            = var.lb_tg_health_check_protocol 
    port                = var.lb_tg_health_check_port 
    path                = var.lb_tg_health_check_path  
    healthy_threshold   = var.lb_tg_health_check_healthy_threshold
    unhealthy_threshold = var.lb_tg_health_check_unhealthy_threshold
    timeout             = var.lb_tg_health_check_timeout
    interval            = var.lb_tg_health_check_interval 
    matcher             = var.lb_tg_health_check_matcher 
  }

  tags = {
    Name = "asg-${var.std_name}-lb-target-group"
    Terraform    = var.common_tags["Terraform"]
    Environment  = var.common_tags["Environment"]
    Owner        = var.common_tags["Owner"]
  }
}

resource "aws_lb_listener" "asg_lb_listener" {
  load_balancer_arn = aws_lb.asg_app_lb.arn
  port              = var.lb_tg_listener_port
  protocol          = var.lb_tg_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg_lb_target_group.arn
  }

  tags = {
    Name = "asg-${var.std_name}-lb-listener"
    Terraform    = var.common_tags["Terraform"]
    Environment  = var.common_tags["Environment"]
    Owner        = var.common_tags["Owner"]
  }
}


# Create EC2 Launch Template Resource for Auto Scaling Group
resource "aws_launch_template" "asg_ec2_template" {
  name_prefix   = "asg-${var.std_name}-template"
  image_id      = var.temp_ec2_ami_id
  instance_type = var.temp_instance_type
  user_data     = filebase64("${var.temp_user_data_base64_file}")
  key_name      = data.aws_key_pair.tmp_key_pair.key_name
  vpc_security_group_ids = var.temp_sg_ids
  description   = "This Template for ${var.std_name}-asg Auto Scaling Group"

  dynamic "block_device_mappings" {
    for_each = var.tmp_ebs_block_devices
    content {
      device_name = block_device_mappings.value.device_name

      ebs {
        volume_size           = block_device_mappings.value.volume_size
        volume_type           = block_device_mappings.value.volume_type
        delete_on_termination = block_device_mappings.value.delete_on_termination
        encrypted             = block_device_mappings.value.encrypted
      }
    }
  }

  tags = {
    Name = "asg-${var.std_name}-template"
    Terraform = var.common_tags["Terraform"]
    Environment = var.common_tags["Environment"]
    Owner = var.common_tags["Owner"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


# Create Auto Scaling Group and Policy
resource "aws_autoscaling_group" "asg_group" {
  name_prefix               = "${var.std_name}-asg"
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_capacity
  health_check_grace_period = var.asg_health_check_grace_period
  health_check_type         = var.asg_health_check_type
  vpc_zone_identifier       = var.asg_vpc_zone_identifier 
  launch_template {
       id      = aws_launch_template.asg_ec2_template.id
       version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.asg_lb_target_group.arn] 

  tag {
    key                 = "Name"
    value               = "asg-${var.std_name}-instance"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_policy" "asg_scale_policy" {
  name                   = var.asg_policy_name   
  autoscaling_group_name = aws_autoscaling_group.asg_group.name
  policy_type            = var.asg_policy_type 

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.asg_policy_metric_type
    }

    target_value = var.asg_policy_target_value
  }
}


