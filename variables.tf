#########################################
############# Variables #################
#########################################

# Geo-Cluster VPC & Subnets

variable "geocluster_vpc" {
  description = "Check Point Geocluster VPC ID"
  default     = "vpc-0edacf9d472218800"
}

variable "public_subnet1" {
  description = "Geocluster Public Subnet AZ1 ID"
  default     = "subnet-084d86b05a3fd96d1"
}

variable "public_subnet2" {
  description = "Geocluster Public Subnet AZ2 ID"
  default     = "subnet-06a2d40b49eb0ec44"
}

variable "private_subnet1" {
  description = "Geocluster Private Subnet AZ1 ID"
  default     = "subnet-0f0250227671aed44"
}

variable "private_subnet2" {
  description = "Geocluster Private Subnet AZ2 ID"
  default     = "subnet-05fda60a04e8c8a7f"
}

variable "tgw_subnet1" {
  description = "Geocluster TGW Subnet AZ1 ID"
  default     = "subnet-0b842c0b8b1d593d9"
}

variable "tgw_subnet2" {
  description = "Geocluster TGW Subnet AZ2 ID"
  default     = "subnet-06c382557d12c829a"
}
variable "tgwha_public_rt" {
  description = "Subnet RT associated to geocluster public subnets"
  default     = "rtb-0263aae2e8abb1bb5"
}

variable "tgwha_private_rt" {
  description = "Subnet RT associated to geocluster private subnets"
  default     = "rtb-04570c8a15cd8b243"
}

# Spoke1 VPC & Subnets

variable "spoke1_vpc" {
  description = "Spoke1 VPC"
  default     = "10.1.0.0/16"
}

variable "spoke1_subnet" {
  description = "Spoke1 Subnet for test VM"
  default     = "10.1.1.0/24"
}

# Spoke2 VPC & Subnets

variable "spoke2_vpc" {
  description = "Spoke2 VPC"
  default     = "10.2.0.0/16"
}

variable "spoke2_subnet" {
  description = "Spoke2 Subnet for test VM"
  default     = "10.2.1.0/24"
}

# Management VPC
variable "mgmt_vpc" {
  description = "Check Point Management VPC"
  default     = "10.3.0.0/16"
}

variable "mgmt_subnet" {
  description = "Subnet for Check Point Mgmt"
  default     = "10.3.1.0/24"
}

# Spokes SuperNetwork

variable "allspokes_cidr" {
  description = "Supernet for all spoke VPCs for ease of routing"
  default     = "10.0.0.0/8"
}

# Other Variables

variable "primary_az" {
  description = "Primary AZ of selected region"
  default     = "us-east-2a"
}

variable "secondary_az" {
  description = "Secondary AZ of selected region"
  default     = "us-east-2b"
}

#######################################################
############# Check Point Settings ####################
#######################################################
# Hashed password for the Check Point servers - you can generate this with the command 'openssl passwd -1 <PASSWORD>'
# (Optional) You can instead SSH into the server and run (from clish): 'set user admin password', fowlloed by 'save config'

variable "password_hash" {
  description = "Hashed password for the Check Point servers - Optional but recommended"
  default     = "$1$5b8270b8$XTwkTQUC.Ddce5rSALyBj/"
}

variable "sic_key" {
  description = "OTP to establish connectivity between Mgmt & Security Gateway"
  default     = "vpn123vpn123"
}

variable "cpversion" {
  description = "Check Point version"
  default     = "R80.40-BYOL"
}

variable "key_name" {
  description = "Key Pair to SSH into Check Point instances"
  default     = "Canada"
}

variable "mgmt_instance_type" {
  default = "m5.large"
}

variable "mgmt_iamrole" {
  description = "Already Existing IAM Role for CP Mgmt"
  default     = ""
}

variable "mgmt_hostname" {
  description = "CP Mgmt Hostname"
  default     = "CPMgmt"
}

variable "gateway_instance_type" {
  default = "c5.large"
}

variable "kmskey_identifier" {
  description = "KMS or CMK key Identifier - Use key ID, alias or ARN. Key alias should be prefixed with 'alias/' "
  default     = "alias/aws/ebs"
}

variable "gateway_iamrole" {
  description = "AWS IAM Role for Geocluster Instances API Failover"
  default     = "Checkpoint_EA"
}

variable "gateway_name" {
  description = "Name of Geocluster Instances"
  default     = "TGWHA"
}

variable "gateway_hostname" {
  description = "Geocluster Instances Hostname"
  default     = "tgwha"
}
