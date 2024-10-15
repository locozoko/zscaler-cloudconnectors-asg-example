################################################################################
# Network Infrastructure Resources
################################################################################
# Identify availability zones available for region selected
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

################################################################################
# Private (Cloud Connector) Subnet & Route Tables
################################################################################
# Create subnet for CC network in X availability zones per az_count variable
resource "aws_subnet" "cc_subnet" {
  count = var.byo_subnets == false ? var.az_count : 0

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = var.cc_subnets != null ? element(var.cc_subnets, count.index) : cidrsubnet(try(data.aws_vpc.vpc_selected[0].cidr_block, aws_vpc.vpc[0].cidr_block), 8, count.index + 200)
  vpc_id            = try(data.aws_vpc.vpc_selected[0].id, aws_vpc.vpc[0].id)

  tags = merge(var.global_tags,
    { Name = "${var.name_prefix}-cc-subnet-${count.index + 1}-${var.resource_tag}" }
  )
}

# Or reference existing subnets
data "aws_subnet" "cc_subnet_selected" {
  count = var.byo_subnets == false ? var.az_count : length(var.byo_subnet_ids)
  id    = var.byo_subnets == false ? aws_subnet.cc_subnet[count.index].id : element(var.byo_subnet_ids, count.index)
}


# Create Route Tables for CC subnets pointing to NAT Gateway resource in each AZ or however many were specified. Optionally, point directly to IGW for public deployments
resource "aws_route_table" "cc_rt" {
  count  = var.cc_route_table_enabled ? length(data.aws_subnet.cc_subnet_selected[*].id) : 0
  vpc_id = try(data.aws_vpc.vpc_selected[0].id, aws_vpc.vpc[0].id)
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(data.aws_nat_gateway.ngw_selected[*].id, count.index)
  }

  tags = merge(var.global_tags,
    { Name = "${var.name_prefix}-cc-rt-${count.index + 1}-${var.resource_tag}" }
  )
}

# CC subnet Route Table Association
resource "aws_route_table_association" "cc_rt_asssociation" {
  count          = var.cc_route_table_enabled ? length(data.aws_subnet.cc_subnet_selected[*].id) : 0
  subnet_id      = data.aws_subnet.cc_subnet_selected[count.index].id
  route_table_id = aws_route_table.cc_rt[count.index].id
}
