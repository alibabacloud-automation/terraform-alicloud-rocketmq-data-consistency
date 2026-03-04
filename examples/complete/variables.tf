variable "region" {
  type        = string
  default     = "cn-hangzhou"
  description = "The Alibaba Cloud region where resources will be created"
}

variable "ecs_instance_type" {
  type        = string
  default     = "ecs.t6-c1m2.large"
  description = "The instance type for ECS instances"
}

variable "db_instance_type" {
  type        = string
  default     = "mysql.n2.medium.1"
  description = "The instance type for RDS database"
}

variable "ecs_instance_password" {
  type        = string
  sensitive   = true
  description = "Password for ECS instances. Length 8-30, must contain three types: uppercase letters, lowercase letters, numbers, and special characters"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Password for RDS database. Length 8-32, must contain uppercase letters, lowercase letters, numbers, and special characters"
}

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

variable "app_demo_username" {
  type        = string
  default     = "appuser"
  description = "Username for application demo account. Length 4-16, can only contain letters, numbers, and underscores"
}

variable "app_demo_password" {
  type        = string
  sensitive   = true
  default     = "apppassword"
  description = "Password for application demo account. Length 8-32, must contain uppercase letters, lowercase letters, numbers, and special characters"
}