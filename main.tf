########################################################
############### CHECK POINT GEOCLUSTER #################
########################################################

# Deploys a Check Point TGW HA (cross AZ Cluster) in existing VPC (20201215) 
# Review template YAML from SK111013 & review which parameters you'd like to customize,.  

resource "aws_cloudformation_stack" "checkpoint_geocluster" {
  name = "CP-GEOCLUSTER"

  parameters = {
    VPC                    = var.geocluster_vpc
    PublicSubnetA          = var.public_subnet1
    PublicSubnetB          = var.public_subnet2
    PrivateSubnetA         = var.private_subnet1
    PrivateSubnetB         = var.private_subnet2
    TgwHASubnetA           = var.tgw_subnet1
    TgwHASubnetB           = var.tgw_subnet2
    InternalRouteTable     = var.tgwha_private_rt
    GatewayName            = var.gateway_name
    GatewayInstanceType    = var.gateway_instance_type
    KeyName                = var.key_name
    AllocatePublicAddress  = "true"
    VolumeSize             = "100"
    VolumeEncryption       = var.kmskey_identifier
    EnableInstanceConnect  = "true"
    GatewayPredefinedRole  = var.gateway_iamrole
    GatewayVersion         = var.cpversion
    GatewayPasswordHash    = var.password_hash
    Shell                  = "/bin/bash"
    GatewaySICKey          = var.sic_key
    GatewayHostname        = var.gateway_hostname
    AllowUploadDownload    = "true"
    NTPPrimary             = "169.254.169.123"
    NTPSecondary           = "0.pool.ntp.org"
    GatewayBootstrapScript = ""

  }

  template_url       = "https://cgi-cfts.s3.amazonaws.com/cluster/tgw-ha.yaml"
  capabilities       = ["CAPABILITY_IAM"]
  disable_rollback   = true
  timeout_in_minutes = 30
}

##################################################
############### CHECK POINT MGMT #################
##################################################

# Deploys Check Point Management Server in existing VPC - sk130372
# Comment this section out if already using Mgmt in AWS or on-premises

/*
resource "aws_cloudformation_stack" "CP-Mgmt" {
  name = "TGW-Mgmt"

  parameters = {
    VPC                       = aws_vpc.mgmt_vpc.id
    ManagementSubnet          = aws_subnet.mgmt_subnet.id
    ManagementName            = "TGW-Mgmt"
    ManagementInstanceType    = var.mgmt_instance_type
    AllocatePublicAddress     = "true"
    VolumeSize                = "100"
    VolumeEncryption          = var.kmskey_identifier
    EnableInstanceConnect     = "true"
    ManagementVersion         = var.cpversion
    KeyName                   = var.key_name
    ManagementPasswordHash    = var.password_hash
    Shell                     = "/bin/bash"
    ManagementPermissions     = "Create with read-write permissions"
    ManagementPredefinedRole  = var.mgmt_iamrole
    ManagementSTSRoles        = ""
    ManagementHostname        = var.mgmt_hostname
    PrimaryManagement         = "true"
    AllowUploadDownload       = "true"
    AdminCIDR                 = "0.0.0.0/0"
    GatewayManagement         = "Over the internet"                       #Type Locally managed if over private IPs
    GatewaysAddresses         = "10.4.0.0/16"
    NTPPrimary                = "169.254.169.123"
    NTPSecondary              = "0.pool.ntp.org"
}

  template_url        = "https://cgi-cfts.s3.amazonaws.com/management/management.yaml"
  capabilities        = ["CAPABILITY_IAM"]
  disable_rollback    = true
  timeout_in_minutes  = 30
}
*/


###################################
##### Spoke-1 VPC & Subnets  ######
###################################

resource "aws_vpc" "spoke1_vpc" {
  cidr_block       = var.spoke1_vpc
  instance_tenancy = "default"

  tags = {
    Name = "Spoke1-VPC"
  }
}

resource "aws_subnet" "spoke1_subnet" {
  availability_zone = var.primary_az
  vpc_id            = aws_vpc.spoke1_vpc.id
  cidr_block        = var.spoke1_subnet

  tags = {
    Name = "Spoke1-Internal"
  }
}

###################################
###### Spoke-1 Security Group #####
###################################

resource "aws_security_group" "spoke1_security_group" {
  description = "Spoke1 Jump Server SG"
  vpc_id      = aws_vpc.spoke1_vpc.id

  # SSH access from Allowed_Sources
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from Allowed Sources
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Spoke1 Jump Server SG"
  }

}

####################################
##### Spoke2 VPC &Subnets  ########
####################################

resource "aws_vpc" "spoke2_vpc" {
  cidr_block       = var.spoke2_vpc
  instance_tenancy = "default"

  tags = {
    Name = "Spoke2-VPC"
  }
}

resource "aws_subnet" "spoke2_subnet" {
  availability_zone = var.primary_az
  vpc_id            = aws_vpc.spoke2_vpc.id
  cidr_block        = var.spoke2_subnet

  tags = {
    Name = "Spoke2-Internal"
  }
}

###################################
###### Spoke-2 Security Group #####
###################################

resource "aws_security_group" "spoke2_security_group" {
  description = "Spoke2 SG"
  vpc_id      = aws_vpc.spoke2_vpc.id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Inbound ICMP
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Spoke2-SG"
  }

}

####################################
###### Mgmt VPC &Subnets  ##########
####################################

resource "aws_vpc" "mgmt_vpc" {
  cidr_block       = var.mgmt_vpc
  instance_tenancy = "default"

  tags = {
    Name = "Mgmt-VPC"
  }
}

resource "aws_subnet" "mgmt_subnet" {
  availability_zone = var.primary_az
  vpc_id            = aws_vpc.mgmt_vpc.id
  cidr_block        = var.mgmt_subnet

  tags = {
    Name = "Mgmt-Subnet"
  }
}

####################################
###### Internet Gateways  ##########
####################################

resource "aws_internet_gateway" "mgmt_igw" {
  vpc_id = aws_vpc.mgmt_vpc.id

  tags = {
    Name = "Mgmt-IGW"
  }
}

resource "aws_internet_gateway" "geocluster_igw" {
  vpc_id = var.geocluster_vpc

  tags = {
    Name = "Geocluster-IGW"
  }
}

resource "aws_internet_gateway" "spoke1_igw" {
  vpc_id = aws_vpc.spoke1_vpc.id

  tags = {
    Name = "Spoke1-IGW"
  }

}
