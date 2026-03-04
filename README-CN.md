阿里云 RocketMQ 数据一致性 Terraform 模块

简体中文 | [English](README.md)

# terraform-alicloud-rocketmq-data-consistency

本 Terraform 模块在阿里云上实现了[使用 RocketMQ 的分布式事务解决方案](https://www.aliyun.com/solution/middleware/rocketmq)。它创建了完整的基础设施，包括 VPC、ECS 实例、RDS 数据库和 RocketMQ 资源，用于演示分布式数据一致性。

## 功能特性

- **VPC 和网络基础设施**：创建 VPC、交换机和安全组
- **ECS 实例**：提供生产者和消费者实例，带有自动化设置脚本
- **RDS MySQL 数据库**：设置 MySQL 数据库，包含正确的账户和权限
- **RocketMQ 集成**：配置 RocketMQ 实例，包含主题、消费组和 ACL 规则
- **自动化部署**：使用 ECS 命令自动配置应用环境
- **安全性**：实现适当的安全组规则和 RAM 用户管理

## 架构

该模块创建以下架构：

```
┌─────────────────────────────────────────────────────────────────┐
│                            VPC                                  │
│  ┌─────────────────────┐    ┌─────────────────────────────────┐ │
│  │   ECS 交换机        │    │         RDS 交换机              │ │
│  │                     │    │                                 │ │
│  │ ┌─────────────────┐ │    │ ┌─────────────────────────────┐ │ │
│  │ │ ECS 生产者      │ │    │ │        RDS MySQL            │ │ │
│  │ │ 实例            │ │    │ │        实例                 │ │ │
│  │ └─────────────────┘ │    │ └─────────────────────────────┘ │ │
│  │                     │    │                                 │ │
│  │ ┌─────────────────┐ │    └─────────────────────────────────┘ │
│  │ │ ECS 消费者      │ │                                        │
│  │ │ 实例            │ │    ┌─────────────────────────────────┐ │
│  │ └─────────────────┘ │    │         RocketMQ                │ │
│  └─────────────────────┘    │         实例                    │ │
│                              └─────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

## 使用方法

```hcl
module "rocketmq_data_consistency" {
  source = "alibabacloud-automation/rocketmq-data-consistency/alicloud"

  # 必需变量
  ecs_instance_password = "YourSecurePassword123!"
  db_password          = "YourDBPassword123!"
  rocketmq_password    = "YourRocketMQPassword123!"
  app_demo_password    = "YourAppPassword123!"
}
```

## 示例

- [complete](https://github.com/alibabacloud-automation/terraform-alicloud-rocketmq-data-consistency/tree/main/examples/complete) - 创建完整的 RocketMQ 数据一致性解决方案

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.212.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | 1.271.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_db_account_privilege.account_privilege](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_account_privilege) | resource |
| [alicloud_db_database.rds_database](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.rds_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_ecs_command.run_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invoke_script](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instances](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_rds_account.rds_account](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_account) | resource |
| [alicloud_rocketmq_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rocketmq_account) | resource |
| [alicloud_rocketmq_acl.consumer_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rocketmq_acl) | resource |
| [alicloud_rocketmq_acl.topic1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rocketmq_acl) | resource |
| [alicloud_rocketmq_consumer_group.consumer_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rocketmq_consumer_group) | resource |
| [alicloud_rocketmq_instance.rocketmq](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rocketmq_instance) | resource |
| [alicloud_rocketmq_topic.topic1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rocketmq_topic) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.rules](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.ecs_vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.rds_vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_demo_password"></a> [app\_demo\_password](#input\_app\_demo\_password) | Password for application demo account. Length 8-32, must contain uppercase letters, lowercase letters, numbers, and special characters | `string` | n/a | yes |
| <a name="input_app_demo_username"></a> [app\_demo\_username](#input\_app\_demo\_username) | Username for application demo account. Length 4-16, can only contain letters, numbers, and underscores | `string` | `"appuser"` | no |
| <a name="input_command_timeout"></a> [command\_timeout](#input\_command\_timeout) | Timeout for ECS command execution in seconds | `number` | `3600` | no |
| <a name="input_custom_script"></a> [custom\_script](#input\_custom\_script) | Custom script for ECS instances. If not provided, the default script will be used. | `string` | `null` | no |
| <a name="input_database_character_set"></a> [database\_character\_set](#input\_database\_character\_set) | The character set for the database | `string` | `"utf8"` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the database to create | `string` | `"testrmq"` | no |
| <a name="input_db_account_name"></a> [db\_account\_name](#input\_db\_account\_name) | The account name for RDS database | `string` | `"db_normal_account"` | no |
| <a name="input_db_engine"></a> [db\_engine](#input\_db\_engine) | The database engine for RDS instance | `string` | `"MySQL"` | no |
| <a name="input_db_engine_version"></a> [db\_engine\_version](#input\_db\_engine\_version) | The database engine version for RDS instance | `string` | `"8.0"` | no |
| <a name="input_db_instance_category"></a> [db\_instance\_category](#input\_db\_instance\_category) | The category of RDS instance | `string` | `"Basic"` | no |
| <a name="input_db_instance_storage"></a> [db\_instance\_storage](#input\_db\_instance\_storage) | The storage size for RDS instance in GB | `number` | `50` | no |
| <a name="input_db_instance_storage_type"></a> [db\_instance\_storage\_type](#input\_db\_instance\_storage\_type) | The storage type of RDS instance | `string` | `"cloud_essd"` | no |
| <a name="input_db_instance_type"></a> [db\_instance\_type](#input\_db\_instance\_type) | The instance type for RDS database | `string` | `"mysql.n2.medium.1"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Password for RDS database. Length 8-32, must contain uppercase letters, lowercase letters, numbers, and special characters | `string` | n/a | yes |
| <a name="input_ecs_command_name"></a> [ecs\_command\_name](#input\_ecs\_command\_name) | The name of the ECS command for all instances | `string` | n/a | yes |
| <a name="input_ecs_consumer_instance_name"></a> [ecs\_consumer\_instance\_name](#input\_ecs\_consumer\_instance\_name) | The name of the ECS consumer instance | `string` | n/a | yes |
| <a name="input_ecs_image_id"></a> [ecs\_image\_id](#input\_ecs\_image\_id) | The image ID for ECS instances | `string` | n/a | yes |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | Password for ECS instances. Length 8-30, must contain three types: uppercase letters, lowercase letters, numbers, and special characters | `string` | n/a | yes |
| <a name="input_ecs_instance_type"></a> [ecs\_instance\_type](#input\_ecs\_instance\_type) | The instance type for ECS instances | `string` | `"ecs.t6-c1m2.large"` | no |
| <a name="input_ecs_provider_instance_name"></a> [ecs\_provider\_instance\_name](#input\_ecs\_provider\_instance\_name) | The name of the ECS provider instance | `string` | n/a | yes |
| <a name="input_ecs_vswitch_cidr_block"></a> [ecs\_vswitch\_cidr\_block](#input\_ecs\_vswitch\_cidr\_block) | The CIDR block for the ECS vSwitch | `string` | `"192.168.1.0/24"` | no |
| <a name="input_ecs_vswitch_name"></a> [ecs\_vswitch\_name](#input\_ecs\_vswitch\_name) | The name of the ECS vSwitch | `string` | n/a | yes |
| <a name="input_ecs_vswitch_zone_id"></a> [ecs\_vswitch\_zone\_id](#input\_ecs\_vswitch\_zone\_id) | The availability zone ID for the ECS vSwitch | `string` | n/a | yes |
| <a name="input_internet_max_bandwidth_out"></a> [internet\_max\_bandwidth\_out](#input\_internet\_max\_bandwidth\_out) | Maximum outgoing bandwidth to the public network, measured in Mbps | `number` | `5` | no |
| <a name="input_rds_instance_name"></a> [rds\_instance\_name](#input\_rds\_instance\_name) | The name of the RDS instance | `string` | n/a | yes |
| <a name="input_rds_vswitch_cidr_block"></a> [rds\_vswitch\_cidr\_block](#input\_rds\_vswitch\_cidr\_block) | The CIDR block for the RDS vSwitch | `string` | `"192.168.2.0/24"` | no |
| <a name="input_rds_vswitch_name"></a> [rds\_vswitch\_name](#input\_rds\_vswitch\_name) | The name of the RDS vSwitch | `string` | n/a | yes |
| <a name="input_rds_vswitch_zone_id"></a> [rds\_vswitch\_zone\_id](#input\_rds\_vswitch\_zone\_id) | The availability zone ID for the RDS vSwitch | `string` | n/a | yes |
| <a name="input_rocketmq_acl_decision"></a> [rocketmq\_acl\_decision](#input\_rocketmq\_acl\_decision) | Decision for RocketMQ ACL rules | `string` | `"Allow"` | no |
| <a name="input_rocketmq_acl_types"></a> [rocketmq\_acl\_types](#input\_rocketmq\_acl\_types) | ACL types for RocketMQ instance | `list(string)` | <pre>[<br/>  "default",<br/>  "apache_acl"<br/>]</pre> | no |
| <a name="input_rocketmq_consumer_group_actions"></a> [rocketmq\_consumer\_group\_actions](#input\_rocketmq\_consumer\_group\_actions) | Actions for RocketMQ consumer group ACL | `list(string)` | <pre>[<br/>  "Sub"<br/>]</pre> | no |
| <a name="input_rocketmq_consumer_group_id"></a> [rocketmq\_consumer\_group\_id](#input\_rocketmq\_consumer\_group\_id) | Consumer group ID for RocketMQ | `string` | `"ROCKETMQ_LOGISTIC_CONSUMER_GROUP"` | no |
| <a name="input_rocketmq_default_vpc_auth_free"></a> [rocketmq\_default\_vpc\_auth\_free](#input\_rocketmq\_default\_vpc\_auth\_free) | Whether to enable default VPC auth-free for RocketMQ instance | `bool` | `false` | no |
| <a name="input_rocketmq_delivery_order_type"></a> [rocketmq\_delivery\_order\_type](#input\_rocketmq\_delivery\_order\_type) | Delivery order type for RocketMQ consumer group | `string` | `"Concurrently"` | no |
| <a name="input_rocketmq_flow_out_type"></a> [rocketmq\_flow\_out\_type](#input\_rocketmq\_flow\_out\_type) | Flow out type for RocketMQ instance | `string` | `"uninvolved"` | no |
| <a name="input_rocketmq_instance_name"></a> [rocketmq\_instance\_name](#input\_rocketmq\_instance\_name) | The name of the RocketMQ instance | `string` | n/a | yes |
| <a name="input_rocketmq_internet_spec"></a> [rocketmq\_internet\_spec](#input\_rocketmq\_internet\_spec) | Internet specification for RocketMQ instance | `string` | `"disable"` | no |
| <a name="input_rocketmq_max_retry_times"></a> [rocketmq\_max\_retry\_times](#input\_rocketmq\_max\_retry\_times) | Maximum retry times for RocketMQ consumer group | `number` | `5` | no |
| <a name="input_rocketmq_message_retention_time"></a> [rocketmq\_message\_retention\_time](#input\_rocketmq\_message\_retention\_time) | Message retention time in hours for RocketMQ instance | `string` | `"70"` | no |
| <a name="input_rocketmq_message_type"></a> [rocketmq\_message\_type](#input\_rocketmq\_message\_type) | Message type for RocketMQ topic | `string` | `"TRANSACTION"` | no |
| <a name="input_rocketmq_msg_process_spec"></a> [rocketmq\_msg\_process\_spec](#input\_rocketmq\_msg\_process\_spec) | Message processing specification for RocketMQ instance | `string` | `"rmq.s2.2xlarge"` | no |
| <a name="input_rocketmq_password"></a> [rocketmq\_password](#input\_rocketmq\_password) | Password for RocketMQ account. Length 8-32, must contain uppercase letters, lowercase letters, numbers, and special characters | `string` | n/a | yes |
| <a name="input_rocketmq_payment_type"></a> [rocketmq\_payment\_type](#input\_rocketmq\_payment\_type) | Payment type for RocketMQ instance | `string` | `"PayAsYouGo"` | no |
| <a name="input_rocketmq_retry_policy"></a> [rocketmq\_retry\_policy](#input\_rocketmq\_retry\_policy) | Retry policy for RocketMQ consumer group | `string` | `"DefaultRetryPolicy"` | no |
| <a name="input_rocketmq_series_code"></a> [rocketmq\_series\_code](#input\_rocketmq\_series\_code) | Series code for RocketMQ instance | `string` | `"standard"` | no |
| <a name="input_rocketmq_sub_series_code"></a> [rocketmq\_sub\_series\_code](#input\_rocketmq\_sub\_series\_code) | Sub-series code for RocketMQ instance | `string` | `"cluster_ha"` | no |
| <a name="input_rocketmq_topic_actions"></a> [rocketmq\_topic\_actions](#input\_rocketmq\_topic\_actions) | Actions for RocketMQ topic ACL | `list(string)` | <pre>[<br/>  "Pub",<br/>  "Sub"<br/>]</pre> | no |
| <a name="input_rocketmq_topic_name"></a> [rocketmq\_topic\_name](#input\_rocketmq\_topic\_name) | Name of the RocketMQ topic | `string` | `"ROCKETMQ_ORDER_TOPIC"` | no |
| <a name="input_rocketmq_topic_remark"></a> [rocketmq\_topic\_remark](#input\_rocketmq\_topic\_remark) | Remark for the RocketMQ topic | `string` | `"用于存储和传输订单相关的业务消息"` | no |
| <a name="input_rocketmq_username"></a> [rocketmq\_username](#input\_rocketmq\_username) | Username for RocketMQ account. Length 4-16, can only contain letters, numbers, and underscores | `string` | `"rmquser"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | The name of the security group | `string` | n/a | yes |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | List of security group rules to create | <pre>list(object({<br/>    type        = string<br/>    ip_protocol = string<br/>    port_range  = string<br/>    priority    = number<br/>    cidr_ip     = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "cidr_ip": "0.0.0.0/0",<br/>    "ip_protocol": "tcp",<br/>    "port_range": "22/22",<br/>    "priority": 1,<br/>    "type": "ingress"<br/>  },<br/>  {<br/>    "cidr_ip": "0.0.0.0/0",<br/>    "ip_protocol": "tcp",<br/>    "port_range": "80/80",<br/>    "priority": 1,<br/>    "type": "ingress"<br/>  }<br/>]</pre> | no |
| <a name="input_system_disk_category"></a> [system\_disk\_category](#input\_system\_disk\_category) | The category of system disk for ECS instances | `string` | `"cloud_essd"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The CIDR block for the VPC | `string` | `"192.168.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_consumer_instance_id"></a> [ecs\_consumer\_instance\_id](#output\_ecs\_consumer\_instance\_id) | The ID of the ECS consumer instance |
| <a name="output_ecs_consumer_public_ip"></a> [ecs\_consumer\_public\_ip](#output\_ecs\_consumer\_public\_ip) | The public IP address of the ECS consumer instance |
| <a name="output_ecs_provider_instance_id"></a> [ecs\_provider\_instance\_id](#output\_ecs\_provider\_instance\_id) | The ID of the ECS provider instance |
| <a name="output_ecs_provider_public_ip"></a> [ecs\_provider\_public\_ip](#output\_ecs\_provider\_public\_ip) | The public IP address of the ECS provider instance |
| <a name="output_ecs_vswitch_id"></a> [ecs\_vswitch\_id](#output\_ecs\_vswitch\_id) | The ID of the ECS vSwitch |
| <a name="output_rds_account_name"></a> [rds\_account\_name](#output\_rds\_account\_name) | The name of the RDS account |
| <a name="output_rds_connection_string"></a> [rds\_connection\_string](#output\_rds\_connection\_string) | The connection string of the RDS instance |
| <a name="output_rds_database_name"></a> [rds\_database\_name](#output\_rds\_database\_name) | The name of the RDS database |
| <a name="output_rds_instance_id"></a> [rds\_instance\_id](#output\_rds\_instance\_id) | The ID of the RDS instance |
| <a name="output_rds_vswitch_id"></a> [rds\_vswitch\_id](#output\_rds\_vswitch\_id) | The ID of the RDS vSwitch |
| <a name="output_rocketmq_consumer_group_id"></a> [rocketmq\_consumer\_group\_id](#output\_rocketmq\_consumer\_group\_id) | The ID of the RocketMQ consumer group |
| <a name="output_rocketmq_endpoint"></a> [rocketmq\_endpoint](#output\_rocketmq\_endpoint) | The endpoint URL of the RocketMQ instance |
| <a name="output_rocketmq_instance_id"></a> [rocketmq\_instance\_id](#output\_rocketmq\_instance\_id) | The ID of the RocketMQ instance |
| <a name="output_rocketmq_topic_name"></a> [rocketmq\_topic\_name](#output\_rocketmq\_topic\_name) | The name of the RocketMQ topic |
| <a name="output_rocketmq_username"></a> [rocketmq\_username](#output\_rocketmq\_username) | The username of the RocketMQ account |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_web_url"></a> [web\_url](#output\_web\_url) | The URL of the demo web application |
<!-- END_TF_DOCS -->

## 安全考虑

1. **密码安全**：所有密码都标记为敏感信息，应安全存储
2. **网络安全**：安全组配置了最小必需的访问权限
3. **数据库安全**：RDS 实例部署在私有子网中，访问受限
4. **RAM 安全**：RAM 用户创建时具有最小必需权限

## 成本考虑

此模块创建多个计费资源：

- ECS 实例（2个）
- RDS MySQL 实例
- RocketMQ 实例
- VPC NAT 网关（如需互联网访问）
- 数据传输成本

预估月成本：100-300 美元（因地域和实例类型而异）

## 故障排除

### 常见问题

1. **实例类型可用性**：确保指定的实例类型在您的地域中可用
2. **密码要求**：密码必须满足复杂性要求
3. **资源限制**：检查您账户的 ECS、RDS 和 RocketMQ 实例限制
4. **网络配置**：确保 CIDR 块与现有网络不重叠

### 调试

1. 在阿里云控制台检查 ECS 命令执行日志
2. 验证 RocketMQ 实例状态和网络配置
3. 从 ECS 实例测试数据库连接
4. 监控应用日志以了解事务处理情况

## 提交问题

如果您在使用此模块时遇到任何问题，请开启一个 [GitHub Issue](https://github.com/alibabacloud-automation/terraform-alicloud-rocketmq-data-consistency/issues)。

## 作者

由阿里云 Terraform Team 创建和维护 (terraform@alibabacloud.com)。

## 许可证

MIT License。详情请见 [LICENSE](https://github.com/alibabacloud-automation/terraform-alicloud-rocketmq-data-consistency/blob/main/LICENSE)。

## 参考

- [Terraform AliCloud Provider 文档](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
- [什么是 RocketMQ](https://www.alibabacloud.com/help/zh/rocketmq/)
- [Terraform Module Registry](https://registry.terraform.io/modules/alibabacloud-automation/rocketmq-data-consistency/alicloud)