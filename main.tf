# Local values for ECS command scripts
locals {
  default_script = <<-EOT
    cat << EOF >> ~/.bash_profile
    export MYSQL_HOST=${alicloud_db_instance.rds_instance.connection_string}
    export MYSQL_DB=${alicloud_db_database.rds_database.data_base_name}
    export MYSQL_USER=${alicloud_rds_account.rds_account.account_name}
    export MYSQL_PASSWORD=${alicloud_rds_account.rds_account.account_password}
    export APP_DEMO_ROCKETMQ_ENDPOINT=${alicloud_rocketmq_instance.rocketmq.network_info[0].endpoints[0].endpoint_url}
    export APP_DEMO_ROCKETMQ_USERNAME=${alicloud_rocketmq_account.default.username}
    export APP_DEMO_ROCKETMQ_PASSWORD=${alicloud_rocketmq_account.default.password}
    export APP_DEMO_USERNAME=${var.app_demo_username}
    export APP_DEMO_PASSWORD=${var.app_demo_password}

    EOF

    source ~/.bash_profile

    curl -fsSL https://help-static-aliyun-doc.aliyuncs.com/install-script/rocketmq-transaction/install.sh|bash
  EOT
}

# VPC and networking resources
resource "alicloud_vpc" "vpc" {
  vpc_name   = var.vpc_name
  cidr_block = var.vpc_cidr_block
}

resource "alicloud_vswitch" "ecs_vswitch" {
  vswitch_name = var.ecs_vswitch_name
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.ecs_vswitch_cidr_block
  zone_id      = var.ecs_vswitch_zone_id
}

resource "alicloud_vswitch" "rds_vswitch" {
  vswitch_name = var.rds_vswitch_name
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.rds_vswitch_cidr_block
  zone_id      = var.rds_vswitch_zone_id
}

# Security group and rules
resource "alicloud_security_group" "security_group" {
  security_group_name = var.security_group_name
  vpc_id              = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "rules" {
  for_each = {
    for idx, rule in var.security_group_rules :
    "${rule.type}-${rule.ip_protocol}-${rule.port_range}" => rule
  }

  type              = each.value.type
  ip_protocol       = each.value.ip_protocol
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = each.value.port_range
  priority          = each.value.priority
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = each.value.cidr_ip
}

# ECS instances
resource "alicloud_instance" "ecs_instances" {
  for_each = {
    provider = { instance_name = var.ecs_provider_instance_name }
    consumer = { instance_name = var.ecs_consumer_instance_name }
  }

  instance_name              = each.value.instance_name
  image_id                   = var.ecs_image_id
  instance_type              = var.ecs_instance_type
  system_disk_category       = var.system_disk_category
  security_groups            = [alicloud_security_group.security_group.id]
  vswitch_id                 = alicloud_vswitch.ecs_vswitch.id
  password                   = var.ecs_instance_password
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
}

# ECS command
resource "alicloud_ecs_command" "run_command" {
  name            = var.ecs_command_name
  command_content = base64encode(var.custom_script != null ? var.custom_script : local.default_script)
  working_dir     = "/root"
  type            = "RunShellScript"
  timeout         = var.command_timeout
}

# ECS invocation
resource "alicloud_ecs_invocation" "invoke_script" {
  instance_id = [
    alicloud_instance.ecs_instances["provider"].id,
    alicloud_instance.ecs_instances["consumer"].id
  ]
  command_id = alicloud_ecs_command.run_command.id
  timeouts {
    create = "15m"
  }
  depends_on = [
    alicloud_rocketmq_acl.topic1,
    alicloud_rocketmq_acl.consumer_group,
  ]
}

# RDS instance
resource "alicloud_db_instance" "rds_instance" {
  instance_name            = var.rds_instance_name
  instance_type            = var.db_instance_type
  zone_id                  = alicloud_vswitch.rds_vswitch.zone_id
  instance_storage         = var.db_instance_storage
  category                 = var.db_instance_category
  db_instance_storage_type = var.db_instance_storage_type
  vswitch_id               = alicloud_vswitch.rds_vswitch.id
  engine                   = var.db_engine
  vpc_id                   = alicloud_vpc.vpc.id
  engine_version           = var.db_engine_version
  security_ips             = [var.vpc_cidr_block]
}

# RDS account
resource "alicloud_rds_account" "rds_account" {
  db_instance_id   = alicloud_db_instance.rds_instance.id
  account_type     = "Normal"
  account_name     = var.db_account_name
  account_password = var.db_password
}

# RDS database
resource "alicloud_db_database" "rds_database" {
  character_set  = var.database_character_set
  instance_id    = alicloud_db_instance.rds_instance.id
  data_base_name = var.database_name
}

# RDS account privilege
resource "alicloud_db_account_privilege" "account_privilege" {
  privilege    = "ReadWrite"
  instance_id  = alicloud_db_instance.rds_instance.id
  account_name = alicloud_rds_account.rds_account.account_name
  db_names     = [alicloud_db_database.rds_database.data_base_name]
}

# RocketMQ instance
resource "alicloud_rocketmq_instance" "rocketmq" {
  instance_name   = var.rocketmq_instance_name
  service_code    = "rmq"
  series_code     = var.rocketmq_series_code
  sub_series_code = var.rocketmq_sub_series_code
  payment_type    = var.rocketmq_payment_type

  product_info {
    msg_process_spec       = var.rocketmq_msg_process_spec
    message_retention_time = var.rocketmq_message_retention_time
  }

  network_info {
    vpc_info {
      vpc_id = alicloud_vpc.vpc.id
      vswitches {
        vswitch_id = alicloud_vswitch.ecs_vswitch.id
      }
    }
    internet_info {
      internet_spec = var.rocketmq_internet_spec
      flow_out_type = var.rocketmq_flow_out_type
    }
  }
  acl_info {
    acl_types             = var.rocketmq_acl_types
    default_vpc_auth_free = var.rocketmq_default_vpc_auth_free
  }
}

# RocketMQ account
resource "alicloud_rocketmq_account" "default" {
  account_status = "ENABLE"
  instance_id    = alicloud_rocketmq_instance.rocketmq.id
  username       = var.rocketmq_username
  password       = var.rocketmq_password
}

# RocketMQ topic
resource "alicloud_rocketmq_topic" "topic1" {
  instance_id  = alicloud_rocketmq_instance.rocketmq.id
  remark       = var.rocketmq_topic_remark
  message_type = var.rocketmq_message_type
  topic_name   = var.rocketmq_topic_name
}

# RocketMQ consumer group
resource "alicloud_rocketmq_consumer_group" "consumer_group" {
  consumer_group_id   = var.rocketmq_consumer_group_id
  instance_id         = alicloud_rocketmq_instance.rocketmq.id
  delivery_order_type = var.rocketmq_delivery_order_type
  consume_retry_policy {
    retry_policy    = var.rocketmq_retry_policy
    max_retry_times = var.rocketmq_max_retry_times
  }
}

# RocketMQ ACL for topic
resource "alicloud_rocketmq_acl" "topic1" {
  actions       = var.rocketmq_topic_actions
  instance_id   = alicloud_rocketmq_instance.rocketmq.id
  username      = alicloud_rocketmq_account.default.username
  resource_name = alicloud_rocketmq_topic.topic1.topic_name
  resource_type = "Topic"
  decision      = var.rocketmq_acl_decision
  ip_whitelists = [var.vpc_cidr_block]
}

# RocketMQ ACL for consumer group
resource "alicloud_rocketmq_acl" "consumer_group" {
  actions       = var.rocketmq_consumer_group_actions
  instance_id   = alicloud_rocketmq_instance.rocketmq.id
  username      = alicloud_rocketmq_account.default.username
  resource_name = alicloud_rocketmq_consumer_group.consumer_group.consumer_group_id
  resource_type = "Group"
  decision      = var.rocketmq_acl_decision
  ip_whitelists = [var.vpc_cidr_block]
}