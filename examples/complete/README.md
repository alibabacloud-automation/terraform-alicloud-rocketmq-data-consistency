# complete

This example demonstrates how to use the RocketMQ Data Consistency module to create a complete distributed transaction solution using RocketMQ.

## Usage

To run this example, you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money. Run `terraform destroy` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| alicloud | >= 1.212.0 |

## Providers

| Name | Version |
|------|---------|
| alicloud | >= 1.212.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | The Alibaba Cloud region where resources will be created | `string` | `"cn-hangzhou"` | no |
| ecs_instance_type | The instance type for ECS instances | `string` | `"ecs.t6-c1m2.large"` | no |
| db_instance_type | The instance type for RDS database | `string` | `"mysql.n2.medium.1"` | no |
| ecs_instance_password | Password for ECS instances. Length 8-30, must contain three types: uppercase letters, lowercase letters, numbers, and special characters | `string` | n/a | yes |
| db_password | Password for RDS database. Length 8-32, must contain uppercase letters, lowercase letters, numbers, and special characters | `string` | n/a | yes |
| rocketmq_username | Username for RocketMQ account. Length 4-16, can only contain letters, numbers, and underscores | `string` | `"rmquser"` | no |
| rocketmq_password | Password for RocketMQ account. Length 8-32, must contain uppercase letters, lowercase letters, numbers, and special characters | `string` | n/a | yes |
| app_demo_username | Username for application demo account. Length 4-16, can only contain letters, numbers, and underscores | `string` | `"appuser"` | no |
| app_demo_password | Password for application demo account. Length 8-32, must contain uppercase letters, lowercase letters, numbers, and special characters | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| web_url | The URL of the demo web application |
| vpc_id | The ID of the VPC |
| rds_instance_id | The ID of the RDS instance |
| rocketmq_instance_id | The ID of the RocketMQ instance |
| ecs_provider_instance_id | The ID of the ECS provider instance |
| ecs_consumer_instance_id | The ID of the ECS consumer instance |