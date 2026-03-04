# ============================================================
# VPC and Network Resources
# ============================================================

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "192.168.0.0/16"
  description = "The CIDR block for the VPC"
}

variable "ecs_vswitch_name" {
  type        = string
  description = "The name of the ECS vSwitch"
}

variable "ecs_vswitch_zone_id" {
  type        = string
  description = "The availability zone ID for the ECS vSwitch"
}

variable "ecs_vswitch_cidr_block" {
  type        = string
  default     = "192.168.1.0/24"
  description = "The CIDR block for the ECS vSwitch"
}

variable "rds_vswitch_name" {
  type        = string
  description = "The name of the RDS vSwitch"
}

variable "rds_vswitch_zone_id" {
  type        = string
  description = "The availability zone ID for the RDS vSwitch"
}

variable "rds_vswitch_cidr_block" {
  type        = string
  default     = "192.168.2.0/24"
  description = "The CIDR block for the RDS vSwitch"
}

# ============================================================
# Security Group Resources
# ============================================================

variable "security_group_name" {
  type        = string
  description = "The name of the security group"
}

variable "security_group_rules" {
  type = list(object({
    type        = string
    ip_protocol = string
    port_range  = string
    priority    = number
    cidr_ip     = string
  }))
  default = [
    {
      type        = "ingress"
      ip_protocol = "tcp"
      port_range  = "22/22"
      priority    = 1
      cidr_ip     = "0.0.0.0/0"
    },
    {
      type        = "ingress"
      ip_protocol = "tcp"
      port_range  = "80/80"
      priority    = 1
      cidr_ip     = "0.0.0.0/0"
    }
  ]
  description = "List of security group rules to create"
}

# ============================================================
# ECS Instance Resources
# ============================================================

variable "ecs_provider_instance_name" {
  type        = string
  description = "The name of the ECS provider instance"
}

variable "ecs_consumer_instance_name" {
  type        = string
  description = "The name of the ECS consumer instance"
}

variable "ecs_instance_type" {
  type        = string
  default     = "ecs.t6-c1m2.large"
  description = "The instance type for ECS instances"
}

variable "ecs_image_id" {
  type        = string
  description = "The image ID for ECS instances"
}

variable "ecs_instance_password" {
  type        = string
  sensitive   = true
  description = "Password for ECS instances. Length 8-30, must contain three types: uppercase letters, lowercase letters, numbers, and special characters"
}

variable "system_disk_category" {
  type        = string
  default     = "cloud_essd"
  description = "The category of system disk for ECS instances"
}

variable "internet_max_bandwidth_out" {
  type        = number
  default     = 5
  description = "Maximum outgoing bandwidth to the public network, measured in Mbps"
}

variable "ecs_command_name" {
  type        = string
  description = "The name of the ECS command for all instances"
}

variable "command_timeout" {
  type        = number
  default     = 3600
  description = "Timeout for ECS command execution in seconds"
}

variable "custom_script" {
  type        = string
  default     = null
  description = "Custom script for ECS instances. If not provided, the default script will be used."
}

# ============================================================
# RDS Database Resources
# ============================================================

variable "rds_instance_name" {
  type        = string
  description = "The name of the RDS instance"
}

variable "db_instance_type" {
  type        = string
  default     = "mysql.n2.medium.1"
  description = "The instance type for RDS database"
}

variable "db_instance_storage" {
  type        = number
  default     = 50
  description = "The storage size for RDS instance in GB"
}

variable "db_instance_category" {
  type        = string
  default     = "Basic"
  description = "The category of RDS instance"
}

variable "db_instance_storage_type" {
  type        = string
  default     = "cloud_essd"
  description = "The storage type of RDS instance"
}

variable "db_engine" {
  type        = string
  default     = "MySQL"
  description = "The database engine for RDS instance"
}

variable "db_engine_version" {
  type        = string
  default     = "8.0"
  description = "The database engine version for RDS instance"
}

variable "db_account_name" {
  type        = string
  default     = "db_normal_account"
  description = "The account name for RDS database"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Password for RDS database. Length 8-32, must contain uppercase letters, lowercase letters, numbers, and special characters"
}

variable "database_name" {
  type        = string
  default     = "testrmq"
  description = "The name of the database to create"
}

variable "database_character_set" {
  type        = string
  default     = "utf8"
  description = "The character set for the database"
}

# ============================================================
# RocketMQ Instance Resources
# ============================================================

variable "rocketmq_instance_name" {
  type        = string
  description = "The name of the RocketMQ instance"
}

variable "rocketmq_series_code" {
  type        = string
  default     = "standard"
  description = "Series code for RocketMQ instance"
}

variable "rocketmq_sub_series_code" {
  type        = string
  default     = "cluster_ha"
  description = "Sub-series code for RocketMQ instance"
}

variable "rocketmq_payment_type" {
  type        = string
  default     = "PayAsYouGo"
  description = "Payment type for RocketMQ instance"
}

variable "rocketmq_msg_process_spec" {
  type        = string
  default     = "rmq.s2.2xlarge"
  description = "Message processing specification for RocketMQ instance"
}

variable "rocketmq_message_retention_time" {
  type        = string
  default     = "70"
  description = "Message retention time in hours for RocketMQ instance"
}

variable "rocketmq_internet_spec" {
  type        = string
  default     = "disable"
  description = "Internet specification for RocketMQ instance"
}

variable "rocketmq_flow_out_type" {
  type        = string
  default     = "uninvolved"
  description = "Flow out type for RocketMQ instance"
}

variable "rocketmq_acl_types" {
  type        = list(string)
  default     = ["default", "apache_acl"]
  description = "ACL types for RocketMQ instance"
}

variable "rocketmq_default_vpc_auth_free" {
  type        = bool
  default     = false
  description = "Whether to enable default VPC auth-free for RocketMQ instance"
}

# ============================================================
# RocketMQ Account Resources
# ============================================================

variable "rocketmq_username" {
  type        = string
  default     = "rmquser"
  description = "Username for RocketMQ account. Length 4-16, can only contain letters, numbers, and underscores"
}

variable "rocketmq_password" {
  type        = string
  sensitive   = true
  description = "Password for RocketMQ account. Length 8-32, must contain uppercase letters, lowercase letters, numbers, and special characters"
}

# ============================================================
# RocketMQ Topic Resources
# ============================================================

variable "rocketmq_topic_name" {
  type        = string
  default     = "ROCKETMQ_ORDER_TOPIC"
  description = "Name of the RocketMQ topic"
}

variable "rocketmq_topic_remark" {
  type        = string
  default     = "用于存储和传输订单相关的业务消息"
  description = "Remark for the RocketMQ topic"
}

variable "rocketmq_message_type" {
  type        = string
  default     = "TRANSACTION"
  description = "Message type for RocketMQ topic"
}

# ============================================================
# RocketMQ Consumer Group Resources
# ============================================================

variable "rocketmq_consumer_group_id" {
  type        = string
  default     = "ROCKETMQ_LOGISTIC_CONSUMER_GROUP"
  description = "Consumer group ID for RocketMQ"
}

variable "rocketmq_delivery_order_type" {
  type        = string
  default     = "Concurrently"
  description = "Delivery order type for RocketMQ consumer group"
}

variable "rocketmq_retry_policy" {
  type        = string
  default     = "DefaultRetryPolicy"
  description = "Retry policy for RocketMQ consumer group"
}

variable "rocketmq_max_retry_times" {
  type        = number
  default     = 5
  description = "Maximum retry times for RocketMQ consumer group"
}

# ============================================================
# RocketMQ ACL Resources
# ============================================================

variable "rocketmq_topic_actions" {
  type        = list(string)
  default     = ["Pub", "Sub"]
  description = "Actions for RocketMQ topic ACL"
}

variable "rocketmq_consumer_group_actions" {
  type        = list(string)
  default     = ["Sub"]
  description = "Actions for RocketMQ consumer group ACL"
}

variable "rocketmq_acl_decision" {
  type        = string
  default     = "Allow"
  description = "Decision for RocketMQ ACL rules"
}

# ============================================================
# Application Demo Variables
# ============================================================

variable "app_demo_username" {
  type        = string
  default     = "appuser"
  description = "Username for application demo account. Length 4-16, can only contain letters, numbers, and underscores"
}

variable "app_demo_password" {
  type        = string
  sensitive   = true
  description = "Password for application demo account. Length 8-32, must contain uppercase letters, lowercase letters, numbers, and special characters"
}
