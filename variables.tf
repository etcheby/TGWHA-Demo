#########################################
############# Variables #################
#########################################

# Geo-Cluster VPC & Subnets

variable "geocluster_vpc_cidr" {
  description = "Check Point Geocluster VPC CIDR Block"
  default     = "10.4.0.0/16"
}

variable "public_subnet1_cidr" {
  description = "Geocluster Public Subnet AZ1 CIDR"
  default     = "10.4.1.0/24"
}

variable "public_subnet2_cidr" {
  description = "Geocluster Public Subnet AZ2"
  default     = "10.4.2.0/24"
}

variable "private_subnet1_cidr" {
  description = "Geocluster Private Subnet AZ1"
  default     = "10.4.3.0/24"
}

variable "private_subnet2_cidr" {
  description = "Geocluster Private Subnet AZ2"
  default     = "10.4.4.0/24"
}

variable "tgw_subnet1_cidr" {
  description = "Geocluster TGW Subnet AZ1"
  default     = "10.4.5.0/24"
}

variable "tgw_subnet2_cidr" {
  description = "Geocluster TGW Subnet AZ2"
  default     = "10.4.6.0/24"
}

# Spoke1 VPC & Subnets

variable "spoke1_vpc_cidr" {
  description = "Spoke1 VPC"
  default     = "10.1.0.0/16"
}

variable "spoke1_subnet_cidr" {
  description = "Spoke1 Subnet for test VM"
  default     = "10.1.1.0/24"
}

# Spoke2 VPC & Subnets

variable "spoke2_vpc_cidr" {
  description = "Spoke2 VPC"
  default     = "10.2.0.0/16"
}

variable "spoke2_subnet_cidr" {
  description = "Spoke2 Subnet for test VM"
  default     = "10.2.1.0/24"
}

# Management VPC
variable "mgmt_vpc_cidr" {
  description = "Check Point Management VPC"
  default     = "10.3.0.0/16"
}

variable "mgmt_subnet_cidr" {
  description = "Subnet for Check Point Mgmt"
  default     = "10.3.1.0/24"
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
  default     = "R80.40"
}

variable "key_name" {
  description = "Key Pair to SSH into Check Point instances"
  default     = "Canada"
}

variable "mgmt_instance_type" {
  default = "m5.large"
}

variable "gateway_instance_type" {
  default = "c5.large"
}

variable "primary_az" {
  description = "primary AZ"
  default     = "ca-central-1a"
}

variable "secondary_az" {
  description = "secondary AZ"
  default     = "ca-central-1b"
}