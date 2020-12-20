#########################################
############# Variables #################
#########################################

# Geo-Cluster VPC & Subnets

variable "geocluster_vpc" {
  description = "Check Point Geocluster VPC ID"
  default     = ""
}

variable "public_subnet1" {
  description = "Geocluster Public Subnet AZ1 ID"
  default     = ""
}

variable "public_subnet2" {
  description = "Geocluster Public Subnet AZ2 ID"
  default     = ""

variable "private_subnet1" {
  description = "Geocluster Private Subnet AZ1 ID"
  default     = ""
}

variable "private_subnet2" {
  description = "Geocluster Private Subnet AZ2 ID"
  default     = ""
}

variable "tgw_subnet1" {
  description = "Geocluster TGW Subnet AZ1 ID"
  default     = ""
}

variable "tgw_subnet2" {
  description = "Geocluster TGW Subnet AZ2 ID"
  default     = ""
}
variable "tgwha_public_rt" {
  description = "Existing Subnet RT ID associated to geocluster public subnets"
  default     = ""
}

variable "tgwha_private_rt" {
  description = "Subnet RT ID associated to geocluster private subnets"
  default     = ""
}

# Spoke1 VPC & Subnets

variable "spoke1_vpc" {
  description = "Spoke1 VPC"
  default     = ""
}

variable "spoke1_subnet" {
  description = "Spoke1 Subnet for test VM"
  default     = ""
}

# Spoke2 VPC & Subnets

variable "spoke2_vpc" {
  description = "Spoke2 VPC"
  default     = ""
}

variable "spoke2_subnet" {
  description = "Spoke2 Subnet for test VM"
  default     = ""
}

# Management VPC
variable "mgmt_vpc" {
  description = "Check Point Management VPC"
  default     = ""
}

variable "mgmt_subnet" {
  description = "Subnet for Check Point Mgmt"
  default     = ""
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
  default     = ""
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
  description = "IAM Role Name for Geocluster Instances API Failover"
  default     = ""
}

variable "gateway_name" {
  description = "Name of Geocluster Instances"
  default     = "TGWHA"
}

variable "gateway_hostname" {
  description = "Geocluster Instances Hostname"
  default     = "tgwha"
}
