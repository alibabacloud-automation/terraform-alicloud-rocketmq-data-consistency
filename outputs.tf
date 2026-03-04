# VPC outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = alicloud_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = alicloud_vpc.vpc.cidr_block
}

# VSwitch outputs
output "ecs_vswitch_id" {
  description = "The ID of the ECS vSwitch"
  value       = alicloud_vswitch.ecs_vswitch.id
}

output "rds_vswitch_id" {
  description = "The ID of the RDS vSwitch"
  value       = alicloud_vswitch.rds_vswitch.id
}

# Security Group outputs
output "security_group_id" {
  description = "The ID of the security group"
  value       = alicloud_security_group.security_group.id
}

# ECS instance outputs
output "ecs_provider_instance_id" {
  description = "The ID of the ECS provider instance"
  value       = alicloud_instance.ecs_instances["provider"].id
}

output "ecs_provider_public_ip" {
  description = "The public IP address of the ECS provider instance"
  value       = alicloud_instance.ecs_instances["provider"].public_ip
}

output "ecs_consumer_instance_id" {
  description = "The ID of the ECS consumer instance"
  value       = alicloud_instance.ecs_instances["consumer"].id
}

output "ecs_consumer_public_ip" {
  description = "The public IP address of the ECS consumer instance"
  value       = alicloud_instance.ecs_instances["consumer"].public_ip
}

# RDS outputs
output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = alicloud_db_instance.rds_instance.id
}

output "rds_connection_string" {
  description = "The connection string of the RDS instance"
  value       = alicloud_db_instance.rds_instance.connection_string
}

output "rds_database_name" {
  description = "The name of the RDS database"
  value       = alicloud_db_database.rds_database.data_base_name
}

output "rds_account_name" {
  description = "The name of the RDS account"
  value       = alicloud_rds_account.rds_account.account_name
}

# RocketMQ outputs
output "rocketmq_instance_id" {
  description = "The ID of the RocketMQ instance"
  value       = alicloud_rocketmq_instance.rocketmq.id
}

output "rocketmq_endpoint" {
  description = "The endpoint URL of the RocketMQ instance"
  value       = alicloud_rocketmq_instance.rocketmq.network_info[0].endpoints[0].endpoint_url
}

output "rocketmq_topic_name" {
  description = "The name of the RocketMQ topic"
  value       = alicloud_rocketmq_topic.topic1.topic_name
}

output "rocketmq_consumer_group_id" {
  description = "The ID of the RocketMQ consumer group"
  value       = alicloud_rocketmq_consumer_group.consumer_group.consumer_group_id
}

output "rocketmq_username" {
  description = "The username of the RocketMQ account"
  value       = alicloud_rocketmq_account.default.username
}

# Application demo URL
output "web_url" {
  description = "The URL of the demo web application"
  value       = "http://${alicloud_instance.ecs_instances["provider"].public_ip}/login"
}