## 1. Zscaler Cloud Connector Provisioning URL E.g. connector.zscaler.net/api/v1/provUrl?name=aws_prov_url
cc_vm_prov_url = "connector.zscalerthree.net/api/v1/provUrl?name=AWS_NOASG_TerraformCloud"

## 2. AWS Secrets Manager Secret Name from Secrets Manager E.g ZS/CC/credentials
secret_name = "ZOLTAN/CC/ZS3"

## 3. Cloud Connector cloud init provisioning listener port. This is required for GWLB and Health Probe deployments. 
http_probe_port = 50000

## 4. The name string for all Cloud Connector resources created by Terraform for Tag/Name attributes. (Default: zscc)
name_prefix = "zoltan-green"

## 5. AWS region
aws_region = "us-east-1"

## 6. Cloud Connector AWS EC2 Instance size selection. Uncomment ccvm_instance_type line with desired vm size to change.
ccvm_instance_type = "m6i.large"

## 7. Cloud Connector Instance size selection (do not change; leave as small)
cc_instance_size = "small"

## 9. The number of Cloud Connector appliances to provision. Each incremental Cloud Connector will be created in alternating 
##    subnets based on the az_count or byo_subnet_ids variable and loop through for any deployments where cc_count > az_count.
##    E.g. cc_count set to 4 and az_count set to 2 or byo_subnet_ids configured for 2 will create 2x CCs in AZ subnet 1 and 2x CCs in AZ subnet 2
cc_count = 1

## 12. Tag attribute "Owner" assigned to all resoure creation. (Default: "zscc-admin")
owner_tag = "Zoltan Kovacs"

## 13. AWS Gateway Load Balancer (GWLB) Cross-Zone Load Balancing
cross_zone_lb_enabled = true

## 14. Gateway loadbalancing hashing algorithm. Default is 5-tuple
#flow_stickiness                            = "2-tuple"
#flow_stickiness                            = "3-tuple"
flow_stickiness = "5-tuple"

## 15. Indicates how the GWLB handles existing flows when a target is deregistered or marked unhealthy. 
rebalance_enabled = true

## 16. SSH management access from the local VPC (false = SSM only)
mgmt_ssh_enabled = false

## 17. By default, a security group is created and assigned to the CC service interface(s).
##     There is an optional rule that permits Cloud Connector to forward direct traffic out
##     on all ports and protocols. (Default: true). Uncomment if you want to restrict
##     traffic to only the ZIA/ZPA required HTTPS TCP/UDP ports.
all_ports_egress_enabled = true

## 18. Create a single Security Group for all Cloud Connectors in the VPC (true). Set to false if you want 1 per CC EC2
reuse_security_group = true

## 19. Create an IAM Instance Role for all Cloud Connectors in the VPC (true). Set to false if you want 1 per CC EC2
reuse_iam = true

## 20. GWLB VPC Endpoint Service acceptance required (true). No acceptance required (false)
acceptance_required = true

## 21. By default, the VPC Endpoint Service is configured to auto accept any VPC Endpoint registration attempts from any principal in the current AWS Account.
##     Uncomment if you want to override this with more specific/restrictive principals. See https://docs.aws.amazon.com/vpc/latest/privatelink/configure-endpoint-service.html#accept-reject-connection-requests"
#allowed_principals                         = [\"arn:aws:iam::1234567890:root\"]


## 23. EBS Encrypted for the Cloud Connector EC2 instances
ebs_encryption_enabled = true

## 24. By default, EBS encryptions is set to null which uses the AWS default managed/master key.
##     Set as 'alias/<key-alias>' to use an existing customer KMS key"
##     Note: this variable is only enforced if ebs_encryption_enabled is set to true
#byo_kms_key_alias                          = "alias/<customer key alias name>"

## 25. By default, Terraform will create an IAM policy for Cloud Connector instance(s) per
##     the terraform-zscc-iam-aws module. Optional access can be enabled for CCs to
##     subscribe to and utilize cloud workload tagging feature. Uncomment to create the 
##     cc_tags_policy IAM Policy and attach it to the CC IAM Role
cloud_tags_enabled = true

## 26. By default, if Terraform is creating SGs an outbound rule is configured enabling 
##     Zscaler remote support access. Without this firewall access, Zscaler Support may not be able to assist as
##     efficiently if troubleshooting is required. Uncomment if you do not want to enable this rule.
##     For more information, refer to: https://config.zscaler.com/zscaler.net/cloud-branch-connector and 
##     https://help.zscaler.com/cloud-branch-connector/enabling-remote-access
support_access_enabled = true
zssupport_server       = "136.226.16.141/32"
