#####################################
######### Transit GW  ###############
#####################################

# Create the TGW
resource "aws_ec2_transit_gateway" "transit_gateway" {
  description = "TGW to demo Check Point Geocluster"
  auto_accept_shared_attachments = "enable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags {
    Name        = "Demo-TGW"
  }
}

#####################################
#######  TGW Attachments ############
#####################################

# Attach the Management VPC to the TGW
resource "aws_ec2_transit_gateway_vpc_attachment" "mgmt_attachment" {
  subnet_ids         = ["${aws_subnet.mgmt_subnet.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.transit_gateway.id}"
  vpc_id             = "${aws_vpc.mgmt_vpc.id}"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags {
    Name = "Mgmt"
  }
}

# Attach Security VPC to the TGW
resource "aws_ec2_transit_gateway_vpc_attachment" "security_attachment" {
  subnet_ids         = ["${aws_subnet.tgw_subnet1.id}","${aws_subnet.tgw_subnet2.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.transit_gateway.id}"
  vpc_id             = "${aws_vpc.geocluster_vpc.id}"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags {
    Name = "Security"
  }
}

# Attach Spoke1 VPC to the TGW
resource "aws_ec2_transit_gateway_vpc_attachment" "spoke1_vpc_attachment" {
  subnet_ids         = ["${aws_subnet.spoke1_subnet.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.transit_gateway.id}"
  vpc_id             = "${aws_vpc.spoke1_vpc.id}"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags {
    Name = "Spoke1"
  }
}

# Attach Spoke2 VPC to the TGW
resource "aws_ec2_transit_gateway_vpc_attachment" "spoke2_vpc_attachment" {
  subnet_ids         = ["${aws_subnet.spoke2_subnet.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.transit_gateway.id}"
  vpc_id             = "${aws_vpc.spoke2_vpc.id}"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags {
    Name = "Spoke2"
  }
}