#######################################
#######    Mgmt Route Table    ########
#######################################

# Create a Management VPC route tables
resource "aws_route_table" "mgmt_rt" {
  vpc_id     = aws_vpc.mgmt_vpc.id

  # Route to the internet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mgmt_igw.id
  }

  # Route to Geocluster Instances 
  route {
    cidr_block         = var.geocluster_vpc_cidr
    transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }

tags = {
    Name = "Mgmt"
  }
}

    # Mgmt Subnet RT Association
resource "aws_route_table_association" "mgmt_rt_association" {
  subnet_id      = aws_subnet.mgmt_subnet.id
  route_table_id = aws_route_table.mgmt_rt.id
}

#########################
### Public Subnets RT ###
#########################

# Create Public Subnets RT

resource "aws_route_table" "public_subnets_rt" {
  vpc_id     = aws_vpc.geocluster_vpc.id

    # Route to the internet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.geocluster_igw.id
  }

    # Route to Check Point Mgmt
  route {
    cidr_block         = var.mgmt_vpc_cidr
    transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }

    # Route to Spoke1
 route {
   cidr_block         = var.spoke1_vpc_cidr
   transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
 }

    # Route to Spoke2
 route {
   cidr_block         = var.spoke2_vpc_cidr
   transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
 }

tags = {
    Name = "Public Subnets"
  }
}

    # Public Subnets Route Table Association

resource "aws_route_table_association" "public_subnet1_rt_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_subnets_rt.id
}

resource "aws_route_table_association" "public_subnet2_rt_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_subnets_rt.id
}


#######################################
#######    Spoke1 Route Table    ######
#######################################

# Create Spoke1 Subnet RT

resource "aws_route_table" "spoke1_subnet_rt" {
  vpc_id     = aws_vpc.spoke1_vpc.id

    # Inbound from Allowed_Source
  route {
    cidr_block = "24.200.180.8/32"
    gateway_id = aws_internet_gateway.spoke1_igw.id
  }

    # Default Route
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }

tags = {
    Name = "Spoke1"
  }
}

    # Spoke1 Subnet Route Table Association

resource "aws_route_table_association" "spoke1_rt_association" {
  subnet_id      = aws_subnet.spoke1_subnet.id
  route_table_id = aws_route_table.spoke1_subnet_rt.id
}

#######################################
#######    Spoke2 Route Table    ######
#######################################

# Create Spoke2 Subnet RT

resource "aws_route_table" "spoke2_subnet_rt" {
  vpc_id     = aws_vpc.spoke2_vpc.id

    # Default Route
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }

tags = {
    Name = "Spoke2"
  }
}

    # Spoke2 Subnet Route Table Association

resource "aws_route_table_association" "spoke2_rt_association" {
  subnet_id      = aws_subnet.spoke2_subnet.id
  route_table_id = aws_route_table.spoke2_subnet_rt.id
}

########################################################
######## TGW - Security Attachment Route Table #########
########################################################

# Create a TGW RT for Security attachment

resource "aws_ec2_transit_gateway_route_table" "tgw_security_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  tags = {
    Name        = "Security"
  }
}

# Associates the geocluster security VPC attachment to this TGW RT

resource "aws_ec2_transit_gateway_route_table_association" "tgw_security_attachment_association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.security_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_security_rt.id
}

# Propagate Security routes to Mgmt

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_security_attachment_propagation_to_mgmt" {
transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.security_attachment.id
transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_mgmt_rt.id
}

# Propagate Security routes to Spokes

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_security_attachment_propagation_to_spokes" {
transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.security_attachment.id
transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_spokes_rt.id
}

#########################################
######## TGW - Mgmt Route Table #########
#########################################

# Create a TGW RT for the Mgmt

resource "aws_ec2_transit_gateway_route_table" "tgw_mgmt_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  tags = {
    Name  = "Mgmt"
  }
}

# Associate the Mgmt VPC attachment

resource "aws_ec2_transit_gateway_route_table_association" "tgw_mgmt_attachment_association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.mgmt_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_mgmt_rt.id
}

# Propagate Mgmt routes into Security VPC attachment

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_mgmt_attachment_propagation_to_geocluster" {
transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.mgmt_attachment.id
transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_security_rt.id
}

###########################################
######## TGW - Spokes Route Table #########
###########################################

# Create a TGW RT for the Spokes

resource "aws_ec2_transit_gateway_route_table" "tgw_spokes_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  tags = {
    Name        = "Spokes"
  }
}

# Associate the Spokes VPC attachments

resource "aws_ec2_transit_gateway_route_table_association" "tgw_spoke1_attachment_association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.spoke1_vpc_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_spokes_rt.id
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw_spoke2_attachment_association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.spoke2_vpc_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_spokes_rt.id
}

# Propagate Spokes routes into Security VPC attachment

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_spoke1_attachment_propagation_to_geocluster" {
transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.spoke1_vpc_attachment.id
transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_security_rt.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_spoke2_attachment_propagation_to_geocluster" {
transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.spoke2_vpc_attachment.id
transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_security_rt.id
}
