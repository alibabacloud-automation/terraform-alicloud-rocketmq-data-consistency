output "web_url" {
  description = "The URL of the demo web application"
  value       = module.rocketmq_data_consistency.web_url
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.rocketmq_data_consistency.vpc_id
}

output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = module.rocketmq_data_consistency.rds_instance_id
}

output "rocketmq_instance_id" {
  description = "The ID of the RocketMQ instance"
  value       = module.rocketmq_data_consistency.rocketmq_instance_id
}

output "ecs_provider_instance_id" {
  description = "The ID of the ECS provider instance"
  value       = module.rocketmq_data_consistency.ecs_provider_instance_id
}

output "ecs_consumer_instance_id" {
  description = "The ID of the ECS consumer instance"
  value       = module.rocketmq_data_consistency.ecs_consumer_instance_id
}