################
## VPC MODULE ##
################

module "vpc_network_module" {
  source                                            = "./modules/vpc"
  common_tags                                       = var.common_tags
  cidr_block                                        = var.cidr_block
  vpc_subnets_config                                = var.vpc_subnets_config
  vpc_acl_public_inbound_rule_config                = var.vpc_acl_public_inbound_rule_config
  vpc_acl_public_outbound_rule_config               = var.vpc_acl_public_outbound_rule_config
  vpc_acl_web_inbound_rule_config                   = var.vpc_acl_web_inbound_rule_config
  vpc_acl_web_outbound_rule_config                  = var.vpc_acl_web_outbound_rule_config
  vpc_acl_app_inbound_rule_config                   = var.vpc_acl_app_inbound_rule_config
  vpc_acl_app_outbound_rule_config                  = var.vpc_acl_app_outbound_rule_config
  vpc_acl_data_inbound_rule_config                  = var.vpc_acl_data_inbound_rule_config
  vpc_acl_data_outbound_rule_config                 = var.vpc_acl_data_outbound_rule_config
  vpc_sg_public_inbound_rule_config                 = var.vpc_sg_public_inbound_rule_config
  vpc_sg_public_outbound_rule_config                = var.vpc_sg_public_outbound_rule_config
  vpc_sg_web_inbound_rule_config                    = var.vpc_sg_web_inbound_rule_config
  vpc_sg_web_outbound_rule_config                   = var.vpc_sg_web_outbound_rule_config
  vpc_sg_app_inbound_rule_config                    = var.vpc_sg_app_inbound_rule_config
  vpc_sg_app_outbound_rule_config                   = var.vpc_sg_app_outbound_rule_config
  vpc_sg_data_inbound_rule_config                   = var.vpc_sg_data_inbound_rule_config
  vpc_sg_data_outbound_rule_config                  = var.vpc_sg_data_outbound_rule_config
  vpc_rt_route_config                               = var.vpc_rt_route_config 
}

################
## ASG MODULE ##
################

module "asg_module" {
  for_each  = var.asg_configs
  source                                            = "./modules/asg"
  common_tags                                       = var.common_tags
  std_name                                          = each.value.std_name  
  lb_sg_ids                                         = [module.vpc_network_module.output_vpc_sg_ids[each.value.lb_sg_name]]
  lb_subnet_ids                                     = module.vpc_network_module.output_vpc_subnet_ids[each.value.lb_sg_name]
  lb_internal                                       = each.value.lb_internal  
  lb_tg_port                                        = each.value.lb_tg_port
  lb_tg_protocol                                    = each.value.lb_tg_protocol  
  lb_tg_vpc_id                                      = module.vpc_network_module.output_vpc_id
  lb_tg_target_type                                 = each.value.lb_tg_target_type  
  lb_tg_health_check_protocol                       = each.value.lb_tg_health_check_protocol  
  lb_tg_health_check_port                           = each.value.lb_tg_health_check_port  
  lb_tg_health_check_path                           = each.value.lb_tg_health_check_path  
  lb_tg_health_check_healthy_threshold              = each.value.lb_tg_health_check_healthy_threshold  
  lb_tg_health_check_unhealthy_threshold            = each.value.lb_tg_health_check_unhealthy_threshold  
  lb_tg_health_check_timeout                        = each.value.lb_tg_health_check_timeout  
  lb_tg_health_check_interval                       = each.value.lb_tg_health_check_interval  
  lb_tg_health_check_matcher                        = each.value.lb_tg_health_check_matcher  
  lb_tg_listener_port                               = each.value.lb_tg_listener_port  
  lb_tg_listener_protocol                           = each.value.lb_tg_listener_protocol  
  temp_ec2_ami_id                                   = each.value.temp_ec2_ami_id  
  temp_instance_type                                = each.value.temp_instance_type  
  temp_user_data_base64_file                        = each.value.temp_user_data_base64_file  
  temp_key_pair_name                                = each.value.temp_key_pair_name  
  temp_sg_ids                                       = [module.vpc_network_module.output_vpc_sg_ids[each.value.lb_sg_name]]               
  tmp_ebs_block_devices                             = each.value.tmp_ebs_block_devices  
  asg_min_size                                      = each.value.asg_min_size  
  asg_max_size                                      = each.value.asg_max_size  
  asg_desired_capacity                              = each.value.asg_desired_capacity  
  asg_health_check_grace_period                     = each.value.asg_health_check_grace_period  
  asg_health_check_type                             = each.value.asg_health_check_type  
  asg_vpc_zone_identifier                           = module.vpc_network_module.output_vpc_subnet_ids[each.value.lb_sg_name]
  asg_policy_name                                   = each.value.asg_policy_name  
  asg_policy_type                                   = each.value.asg_policy_type  
  asg_policy_metric_type                            = each.value.asg_policy_metric_type  
  asg_policy_target_value                           = each.value.asg_policy_target_value  
} 

################
## RDS MODULE ##
################

module "rds_module" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = "rds-db-cluster"

  engine            = "mysql"
  engine_version          = "8.0.35"
  major_engine_version    = "8.0"
  family                  = "mysql8.0"
  instance_class    = "db.m5.large"
  allocated_storage = 50
  max_allocated_storage = 100
  storage_type      = "gp3"

  db_name  = "rds-app"
  username = "admin"
  password = "123"  # Best stored in secrets manager 
  port     = 3306

  multi_az             = true
  publicly_accessible  = false
  deletion_protection  = true
  skip_final_snapshot  = false
  backup_retention_period = 7
  apply_immediately    = false  # safer for production
  auto_minor_version_upgrade = true

  monitoring_interval = 60

  vpc_security_group_ids = [module.vpc_network_module.output_vpc_sg_ids["data"]]
  subnet_ids             = module.vpc_network_module.output_vpc_subnet_ids["data"]

  tags = {
    Name            = "Production RDS Database"
    Environment     = "production"
    Terraform       = "True"
    Owner           = "DevOps Team" 
  }
}

##########################
## REDIS CACHING MODULE ##
##########################

module "elasticache" {
  source = "terraform-aws-modules/elasticache/aws"
  version = "~> 1.6.0"

  cluster_id               = "redis-cache"
  create_cluster           = true
  create_replication_group = false

  engine_version = "7.1"
  node_type      = "cache.t4g.small"

  maintenance_window = "sun:05:00-sun:09:00"
  apply_immediately  = true

  vpc_id = module.vpc_network_module.output_vpc_id
  subnet_ids = module.vpc_network_module.output_vpc_subnet_ids["web"]

  # Parameter Group
  create_parameter_group = true
  parameter_group_family = "redis7"
  parameters = [
    {
      name  = "latency-tracking"
      value = "yes"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

################
## IAM MODULE ##
################

module "iam_role_ec2" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.0"

  role_name = "ec2-app-role"

  create_role             = true
  role_requires_mfa       = false
  trusted_role_services   = ["ec2.amazonaws.com"]
  custom_role_policy_arns = [aws_iam_policy.read_only_s3.arn]

  tags = {
    Name = "EC2 App Role"
  }
}

resource "aws_iam_policy" "read_only_s3" {
  name        = "ReadOnlyS3Policy"
  description = "Allow EC2 to read only from specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::my-app-bucket",
          "arn:aws:s3:::my-app-bucket/*"
        ]
      }
    ]
  })
}



