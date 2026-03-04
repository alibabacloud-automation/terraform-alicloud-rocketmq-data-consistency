provider "alicloud" {
  region = var.region
}

# Query available zones for ECS instances
data "alicloud_zones" "ecs_zones" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.ecs_instance_type
}

# Query available zones for RDS instances
data "alicloud_db_zones" "rds_zones" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

# Query available Alibaba Cloud Linux images
data "alicloud_images" "default" {
  name_regex  = "^aliyun_3_x64_20G_alibase_.*"
  most_recent = true
  owners      = "system"
}

module "rocketmq_data_consistency" {
  source = "../.."

  # VPC and networking configuration
  vpc_name               = "vpc-rocketmq-demo"
  vpc_cidr_block         = "192.168.0.0/16"
  ecs_vswitch_name       = "vsw-ecs"
  ecs_vswitch_zone_id    = data.alicloud_zones.ecs_zones.zones[0].id
  ecs_vswitch_cidr_block = "192.168.1.0/24"
  rds_vswitch_name       = "vsw-rds"
  rds_vswitch_zone_id    = data.alicloud_db_zones.rds_zones.zones[0].id
  rds_vswitch_cidr_block = "192.168.2.0/24"

  # Security group configuration
  security_group_name = "sg-rocketmq-demo"
  security_group_rules = [
    {
      type        = "ingress"
      ip_protocol = "tcp"
      port_range  = "22/22"
      priority    = 1
      cidr_ip     = "192.168.0.0/16"
    },
    {
      type        = "ingress"
      ip_protocol = "tcp"
      port_range  = "80/80"
      priority    = 1
      cidr_ip     = "192.168.0.0/16"
    }
  ]

  # ECS instance configuration
  ecs_provider_instance_name = "ecs-provider"
  ecs_consumer_instance_name = "ecs-consumer"
  ecs_image_id               = data.alicloud_images.default.images[0].id
  ecs_instance_type          = var.ecs_instance_type
  ecs_instance_password      = var.ecs_instance_password
  internet_max_bandwidth_out = 5
  system_disk_category       = "cloud_essd"

  # ECS command configuration
  ecs_command_name = "cmd-rocketmq-demo"

  # RDS database configuration
  rds_instance_name      = "rds-mysql"
  db_instance_type       = var.db_instance_type
  db_instance_storage    = 50
  db_password            = var.db_password
  db_account_name        = "db_normal_account"
  database_name          = "testrmq"
  database_character_set = "utf8"

  # RocketMQ configuration
  rocketmq_instance_name          = "rmq-demo"
  rocketmq_msg_process_spec       = "rmq.s2.2xlarge"
  rocketmq_message_retention_time = "70"
  rocketmq_username               = var.rocketmq_username
  rocketmq_password               = var.rocketmq_password
  rocketmq_topic_name             = "ROCKETMQ_ORDER_TOPIC"
  rocketmq_consumer_group_id      = "ROCKETMQ_LOGISTIC_CONSUMER_GROUP"

  # Application demo configuration
  app_demo_username = var.app_demo_username
  app_demo_password = var.app_demo_password
}
