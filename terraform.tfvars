## 1. Zscaler Cloud Connector Provisioning URL E.g. connector.zscaler.net/api/v1/provUrl?name=aws_prov_url
cc_vm_prov_url = "connector.zscalerthree.net/api/v1/provUrl?name=AWS_ASG_TerraformCloud"

## 2. AWS Secrets Manager Secret Name from Secrets Manager E.g ZS/CC/credentials
secret_name = "ZOLTAN/CC/ZS3"

## 3. Cloud Connector cloud init provisioning listener port. This is required for GWLB and Health Probe deployments. 
## Uncomment and set custom probe port to a single value of 80 or any number between 1024-65535. Default is 50000.
http_probe_port = 50000

## 4. The name string for all Cloud Connector resources created by Terraform for Tag/Name attributes
name_prefix = "ztest"

## 5. AWS region where Cloud Connector resources will be deployed
aws_region = "us-east-1"

## 6. Cloud Connector AWS EC2 Instance size selection. do not change
ccvm_instance_type = "m6i.large"

## 8. The number of Auto Scaling Groups to create. By default, Terraform will create a single Auto Scaling Group containing multiple subnets/availability zones. 
##    Uncomment and set to true if you would rather create one Auto Scaling Group per subnet/availability zone (var.az_count).
zonal_asg_enabled = true

## 9. The minimum number of Cloud Connectors to maintain in an Autoscaling group. (Default: 2)
##    Recommendation is to maintain HA/Zonal resliency so for example if az_count = 2 and cross_zone_lb_enabled is false the minimum number of CCs you would want for a
##    production deployment would be 4
min_size = 1

## 10. The maximum number of Cloud Connectors to maintain in an Autoscaling group. (Default: 4)
##    Value must be a number between 1 and 10
max_size = 2

## 11. The health check grace period specifies the minimum amount of time (in seconds) to keep a new instance in service before terminating it if it's found to be unhealthy. 
##     Otheriwse Default is 15 minutes. (Default: 900 seconds/15 minutes)
health_check_grace_period = 900

## 12. Amount of time, in seconds, until a newly launched instance can contribute to the Amazon CloudWatch metrics. 
##     This delay lets an instance finish initializing before Amazon EC2 Auto Scaling aggregates instance metrics, resulting in more reliable usage data.
##     Default: 0 seconds
instance_warmup = 0

## 13. Whether newly launched instances are automatically protected from termination by Amazon EC2 Auto Scaling when scaling in. 
##     Uncomment to disable. (Default: true)

## 15. Tag attribute "Owner" assigned to all resoure creation. (Default: "zscc-admin")
owner_tag = "Zoltan-Test"

## 17. By default, GWLB deployments are configured as zonal. Uncomment if you want to enable cross-zone load balancing
##     functionality. Only applicable for gwlb deployment types. (Default: false)
cross_zone_lb_enabled = true

## 18. Gateway loadbalancing hashing algorithm. Default is 5-tuple (None).
##     Additional options include: 2-tuple (source_ip_dest_ip) and 3-tuple (source_ip_dest_ip_proto)
##     Uncomment below the configuration you want to use.
#flow_stickiness                            = "2-tuple"
#flow_stickiness                            = "3-tuple"
flow_stickiness = "5-tuple"

## 19. Indicates how the GWLB handles existing flows when a target is deregistered or marked unhealthy. 
##     true means rebalance after deregistration. false means no_rebalance. (Default: true)
##     Uncomment to turn this feature off (not recommended)
rebalance_enabled = true

## 20. By default, the VPC Endpoint Service is configured to auto accept any VPC Endpoint registration attempts from any principal in the current AWS Account.
##     Uncomment if you want to override this with more specific/restrictive principals. See https://docs.aws.amazon.com/vpc/latest/privatelink/configure-endpoint-service.html#accept-reject-connection-requests"
#allowed_principals                         = [\"arn:aws:iam::1234567890:root\"]

## 21. If set to true, add a warm pool to the specified Auto Scaling group. See [warm_pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group#warm_pool).
##     Uncomment to enable. (Default: false)
warm_pool_enabled = false

## 22. Sets the instance state to transition to after the lifecycle hooks finish. Valid values are: Stopped (default) or Running. Ignored when 'warm_pool_enabled' is false
##     Uncomment the desired value
#warm_pool_state                            = "Stopped"
#warm_pool_state                            = "Running"

## 23. Specifies the minimum number of instances to maintain in the warm pool. This helps you to ensure that there is always a certain number of warmed instances available to handle traffic spikes. Ignored when 'warm_pool_enabled' is false
##     Uncomment and specify a desired minimum number of Cloud Connectors to maintain deployed in a warm pool
#warm_pool_min_size                         = 0

## 24. Specifies the total maximum number of instances that are allowed to be in the warm pool or in any state except Terminated for the Auto Scaling group. Ignored when 'warm_pool_enabled' is false
##     Uncomment and specify a desired maximum number of Cloud Connectors to maintain deployed in a warm pool. Default is null which means use whatever maximum is set at the ASG.
#warm_pool_max_group_prepared_capacity      = null

## 25. Specifies whether instances in the Auto Scaling group can be returned to the warm pool on scale in
##     Uncomment to disable. (Default: true)
reuse_on_scale_in = true

## 26. Target value number for autoscaling policy CPU utilization target tracking. ie: trigger a scale in/out to keep average CPU Utliization percentage across all instances at/under this number
##     (Default: 80%)
target_cpu_util_value = 80

## 27. Determine whether or not to create autoscaling group notifications. Default is false. If setting this value to true, terraform will also create a new sns topic and topic subscription in the same AWS account"
sns_enabled = true

## 28. List of email addresses to input for sns topic subscriptions for autoscaling group notifications. Required if sns_enabled variable is true and byo_sns_topic false
sns_email_list = ["zkovacs@zscaler.com", "zoltan@ikovacs.com"]

## 29. Determine whether or not to create an AWS SNS topic and topic subscription for email alerts. Setting this variable to true implies you should also set variable sns_enabled to true
##     Default: false
#byo_sns_topic                              = false

## 30. Existing SNS Topic friendly name to be used for autoscaling group notifications assignment
#byo_sns_topic_name                         = "topic-name"

## 31. SSH management access from the local VPC is enabled by default (true). Uncomment if you
##     want to disable this.
##     Note: Cloud Connector will only be accessible via AWS Session Manager SSM
mgmt_ssh_enabled = false

## 32. By default, a security group is created and assigned to the CC service interface(s).
##     There is an optional rule that permits Cloud Connector to forward direct traffic out
##     on all ports and protocols. (Default: true). Uncomment if you want to restrict
##     traffic to only the ZIA/ZPA required HTTPS TCP/UDP ports.
all_ports_egress_enabled = true

## 33. By default, terraform will configure Cloud Connector with EBS encryption enabled.
##     Uncomment if you want to disable ebs encryption.
ebs_encryption_enabled = true

## 34. By default, EBS encryptions is set to null which uses the AWS default managed/master key.
##     Set as 'alias/<key-alias>' to use an existing customer KMS key"
#byo_kms_key_alias                          = "alias/<customer key alias name>"

## 35. By default, Terraform will create an IAM policy for Cloud Connector instance(s) per
##     the terraform-zscc-iam-aws module. Optional access can be enabled for CCs to
##     subscribe to and utilize cloud workload tagging feature. Uncomment to create the 
##     cc_tags_policy IAM Policy and attach it to the CC IAM Role
cloud_tags_enabled = true

## 36. By default, if Terraform is creating SGs an outbound rule is configured enabling 
##     Zscaler remote support access. Without this firewall access, Zscaler Support may not be able to assist as
##     efficiently if troubleshooting is required. Uncomment if you do not want to enable this rule.
##     For more information, refer to: https://config.zscaler.com/zscaler.net/cloud-branch-connector and 
##     https://help.zscaler.com/cloud-branch-connector/enabling-remote-access
support_access_enabled = true
zssupport_server       = "136.226.16.141/32"

## 39. By default, this script will create a new AWS VPC.
##     Uncomment if you want to deploy all resources to a VPC that already exists (true or false. Default: false)
byo_vpc = true

## 40. Provide your existing VPC ID. Only uncomment and modify if you set byo_vpc to true. (Default: null)
byo_vpc_id = "vpc-0bd2fa9f99d982a15"

## 41. By default, this script will create new AWS subnets in the VPC defined based on az_count.
##     Uncomment if you want to deploy all resources to subnets that already exist (true or false. Default: false)
##     Dependencies require in order to reference existing subnets, the corresponding VPC must also already exist.
##     Setting byo_subnet to true means byo_vpc must ALSO be set to true.
byo_subnets = true

## 42. Provide your existing Cloud Connector private subnet IDs. Only uncomment and modify if you set byo_subnets to true.
##     Subnet IDs must be added as a list with order determining assocations for resources like aws_instance, NAT GW,
##     Route Tables, etc. Provide only one subnet per Availability Zone in a VPC
##
##     ##### This script will create Route Tables with default 0.0.0.0/0 next-hop to the corresponding NAT Gateways
##     ##### that are created or exists in the VPC Public Subnets. If you already have CC Subnets created, disassociate
##     ##### any route tables to them prior to deploying this script.
##
##     Example: byo_subnet_ids = ["subnet-05c32f4aa6bc02f8f","subnet-13b35f23y6uc36f3s"]
byo_subnet_ids = ["subnet-023e9deec9c6b563c", "subnet-0544bcb7240a85a3c"]

## 43. By default, this script will create a new Internet Gateway resource in the VPC.
##     Uncomment if you want to utlize an IGW that already exists (true or false. Default: false)
##     Dependencies require in order to reference an existing IGW, the corresponding VPC must also already exist.
##     Setting byo_igw to true means byo_vpc must ALSO be set to true.

#byo_igw                                    = true

## 44. Provide your existing Internet Gateway ID. Only uncomment and modify if you set byo_igw to true.
##     Example: byo_igw_id = "igw-090313c21ffed44d3"

#byo_igw_id                                 = "igw-090313c21ffed44d3"

## 45. By default, this script will create new Public Subnets, and NAT Gateway w/ Elastic IP in the VPC defined or selected.
##     It will also create a Route Table forwarding default 0.0.0.0/0 next hop to the Internet Gateway that is created or defined 
##     based on the byo_igw variable and associate with the public subnet(s)
##     Uncomment if you want to deploy Cloud Connectors routing to NAT Gateway(s)/Public Subnet(s) that already exist (true or false. Default: false)
##     
##     Setting byo_ngw to true means no additional Public Subnets, Route Tables, or Elastic IP resources will be created

#byo_ngw                                    = true

## 46. Provide your existing NAT Gateway IDs. Only uncomment and modify if you set byo_cc_subnet to true
#byo_ngw_ids                                = ["nat-id"]

## 47. By default, this script will create new IAM roles, policy, and Instance Profiles for the Cloud Connector
##     Uncomment if you want to use your own existing IAM Instance Profiles (true or false. Default: false)
#byo_iam                                    = true

## 48. Provide your existing Instance Profile resource names. Only uncomment and modify if you set byo_iam to true
#byo_iam_instance_profile_id                = ["instance-profile-1"]

## 49. By default, this script will create new Security Groups for the Cloud Connector mgmt and service interfaces
##     Uncomment if you want to use your own existing SGs (true or false. Default: false)
#byo_security_group                         = true

## 50. Provide your existing Security Group resource names. Only uncomment and modify if you set byo_security_group to true
#byo_mgmt_security_group_id                 = ["mgmt-sg-1"]
#byo_service_security_group_id              = ["service-sg-1"]

## 51. By default, this script will create new route table resources associated to Cloud Connector defined private subnets
##     Uncomment, if you do NOT want to create new route tables (true or false. Default: true)
##     By uncommenting (setting to false) this assumes that you have an existing VPC/Subnets (byo_subnets = true)
cc_route_table_enabled = false
