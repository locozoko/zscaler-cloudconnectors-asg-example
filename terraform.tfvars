## 1. Zscaler Cloud Connector Provisioning URL E.g. connector.zscaler.net/api/v1/provUrl?name=aws_prov_url
cc_vm_prov_url = "insert"

## 2. AWS Secrets Manager Secret Name from Secrets Manager E.g ZS/CC/credentials
secret_name = "insert"

## 3. Cloud Connector cloud init provisioning listener port. Value of 80 or any number between 1024-65535. Default is 50000.
http_probe_port = 50000

## 4. The name string for all Cloud Connector resources created by Terraform for Tag/Name attributes
name_prefix = "insert"

## 5. AWS region where Cloud Connector resources will be deployed
aws_region = "us-east-1"

## 6. Cloud Connector AWS EC2 Instance size selection. do not change
ccvm_instance_type = "m6i.large"

## 8. The number of Auto Scaling Groups to create. By default, Terraform will create a single Auto Scaling Group containing multiple subnets/availability zones. 
##    Uncomment and set to true if you would rather create one Auto Scaling Group per subnet/availability zone (var.az_count).
zonal_asg_enabled = false

## 9. The minimum number of Cloud Connectors to maintain in an Autoscaling group
min_size = 1

## 10. The maximum number of Cloud Connectors to maintain in an Autoscaling group (must be 1 to 10)
max_size = 2

## 11. The health check grace period specifies the minimum amount of time (in seconds) to keep a new instance in service before terminating it if it's found to be unhealthy. 
health_check_grace_period = 900

## 12. Amount of time, in seconds, until a newly launched instance can contribute to the Amazon CloudWatch metrics. 
##     This delay lets an instance finish initializing before Amazon EC2 Auto Scaling aggregates instance metrics, resulting in more reliable usage data.
instance_warmup = 0

## 15. Tag attribute "Owner" assigned to all resoure creation. (Default: "zscc-admin")
owner_tag = "insert"

## 17. By default, GWLB deployments are configured as zonal. Uncomment if you want to enable cross-zone load balancing
##     functionality. Only applicable for gwlb deployment types. (Default: false)
cross_zone_lb_enabled = true

## 18. Gateway loadbalancing hashing algorithm. Default is 5-tuple (None).
#flow_stickiness                            = "2-tuple"
#flow_stickiness                            = "3-tuple"
flow_stickiness = "5-tuple"

## 19. Indicates how the GWLB handles existing flows when a target is deregistered or marked unhealthy (recommended: true)
rebalance_enabled = true

## 20. By default, the VPC Endpoint Service is configured to auto accept any VPC Endpoint registration attempts from any principal in the current AWS Account.
##     Uncomment if you want to override this with more specific/restrictive principals. See https://docs.aws.amazon.com/vpc/latest/privatelink/configure-endpoint-service.html#accept-reject-connection-requests"
#allowed_principals                         = [\"arn:aws:iam::1234567890:root\"]

## 21. If set to true, add a warm pool to the specified Auto Scaling group. See [warm_pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group#warm_pool).
warm_pool_enabled = false

## 22. Sets the instance state to transition to after the lifecycle hooks finish. Valid values are: Stopped (default) or Running. Ignored when 'warm_pool_enabled' is false
#warm_pool_state                            = "Stopped"
#warm_pool_state                            = "Running"

## 23. Specifies the minimum number of instances to maintain in the warm pool. This helps you to ensure that there is always a certain number of warmed instances available to handle traffic spikes. Ignored when 'warm_pool_enabled' is false
#warm_pool_min_size                         = 0

## 24. Specifies the total maximum number of instances that are allowed to be in the warm pool or in any state except Terminated for the Auto Scaling group. Ignored when 'warm_pool_enabled' is false
##     Uncomment and specify a desired maximum number of Cloud Connectors to maintain deployed in a warm pool. Default is null which means use whatever maximum is set at the ASG.
#warm_pool_max_group_prepared_capacity      = null

## 25. Specifies whether instances in the Auto Scaling group can be returned to the warm pool on scale in
reuse_on_scale_in = true

## 26. Target value number for autoscaling policy CPU utilization target tracking. ie: trigger a scale in/out to keep average CPU Utliization percentage across all instances at/under this number
target_cpu_util_value = 80

## 27. Determine whether or not to create autoscaling group notifications. Default is false. If setting this value to true, terraform will also create a new sns topic and topic subscription in the same AWS account"
sns_enabled = true

## 28. List of email addresses to input for sns topic subscriptions for autoscaling group notifications. Required if sns_enabled variable is true and byo_sns_topic false
sns_email_list = ["insert2", "insert2"]

## 29. Determine whether or not to create an AWS SNS topic and topic subscription for email alerts. Setting this variable to true implies you should also set variable sns_enabled to true
#byo_sns_topic                              = false

## 30. Existing SNS Topic friendly name to be used for autoscaling group notifications assignment
#byo_sns_topic_name                         = "topic-name"

## 31. SSH management access from the local VPC is enabled by default (true). False = SSM access only
mgmt_ssh_enabled = false

## 32. By default, a security group is created and assigned to the CC service interface(s) to allow direct traffic out
all_ports_egress_enabled = true

## 33. By default, terraform will configure Cloud Connector with EBS encryption enabled.
##     Uncomment if you want to disable ebs encryption.
ebs_encryption_enabled = true

## 34. By default, EBS encryptions is set to null which uses the AWS default managed/master key.
#byo_kms_key_alias                          = "alias/<customer key alias name>"

## 35. Additional IAM Policy for Cloud Connectors to used Tag Discovery Service feature (once avaialable in fedramp mod cloud)
cloud_tags_enabled = true

## 36. By default, if Terraform is creating SGs an outbound rule is configured enabling 
##     Zscaler remote support access. Without this firewall access, Zscaler Support may not be able to assist as
##     efficiently if troubleshooting is required. Uncomment if you do not want to enable this rule.
##     For more information, refer to: https://config.zscaler.com/zscaler.net/cloud-branch-connector and 
##     https://help.zscaler.com/cloud-branch-connector/enabling-remote-access
support_access_enabled = true
zssupport_server       = "136.226.16.141/32"

## 39. Bring your own VPC
byo_vpc = true

## 40. Provide your existing VPC ID. Only uncomment and modify if you set byo_vpc to true. (Default: null)
byo_vpc_id = "insert"

## 41. Bring your own subnets
byo_subnets = true

## 42. Provide your existing Cloud Connector private subnet IDs
byo_subnet_ids = ["insert1", "insert2"]

## Bring IGW to skip it
byo_igw = true

## 47. By default, this script will create new IAM roles, policy, and Instance Profiles for the Cloud Connector
#byo_iam                                    = true

## 48. Provide your existing Instance Profile resource names. Only uncomment and modify if you set byo_iam to true
#byo_iam_instance_profile_id                = ["instance-profile-1"]

## 49. By default, this script will create new Security Groups for the Cloud Connector mgmt and service interfaces
#byo_security_group                         = true

## 50. Provide your existing Security Group resource names. Only uncomment and modify if you set byo_security_group to true
#byo_mgmt_security_group_id                 = ["mgmt-sg-1"]
#byo_service_security_group_id              = ["service-sg-1"]

## 51. By default, this script will create new route table resources associated to Cloud Connector defined private subnets
##     Uncomment, if you do NOT want to create new route tables (true or false. Default: true)
cc_route_table_enabled = false
