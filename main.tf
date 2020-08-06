#########################################
###### Geocluster VPC & Subnets  ########
#########################################

resource "aws_vpc" "geocluster_vpc"{
  cidr_block       = "${var.geocluster_vpc_cidr}"
  instance_tenancy = "default"
      
  tags {
    Name = "Geocluster"
  }
}

resource "aws_subnet" "public_subnet1" {
  availability_zone = "${var.primary_az}"
  vpc_id            = "${aws_vpc.geocluster_vpc.id}"
  cidr_block        = "${var.public_subnet1_cidr}"
  
  tags {
    Name = "Public 1"
  }
}

resource "aws_subnet" "public_subnet2" {
  availability_zone = "${var.secondary_az}"
  vpc_id            = "${aws_vpc.geocluster_vpc.id}"
  cidr_block        = "${var.public_subnet2_cidr}"
  
  tags {
    Name = "Public 2"
  }
}

resource "aws_subnet" "private1" {
  availability_zone = "${var.primary_az}"
  vpc_id            = "${aws_vpc.geocluster_vpc.id}"
  cidr_block        = "${var.private_subnet1_cidr}"
  
  tags {
    Name = "Private 1"
  }
}

resource "aws_subnet" "private2" {
  availability_zone = "${var.secondary_az}"
  vpc_id            = "${aws_vpc.geocluster_vpc.id}"
  cidr_block        = "${var.private_subnet2_cidr}"
  
  tags {
    Name = "Private 2"
  }
}

resource "aws_subnet" "tgw_subnet1" {
  availability_zone = "${var.primary_az}"
  vpc_id            = "${aws_vpc.geocluster_vpc.id}"
  cidr_block        = "${var.tgw_subnet1_cidr}"
  
  tags {
    Name = "TGW Subnet 1"
  }
}

resource "aws_subnet" "tgw_subnet2" {
  availability_zone = "${var.secondary_az}"
  vpc_id            = "${aws_vpc.geocluster_vpc.id}"
  cidr_block        = "${var.tgw_subnet2_cidr}"
  
  tags {
    Name = "TGW Subnet 2"
  }
}

###################################
##### Spoke-1 VPC & Subnets  ######
###################################

resource "aws_vpc" "spoke1_vpc"{
  cidr_block       = "${var.spoke1_vpc_cidr}"
  instance_tenancy = "default"
      
  tags {
    Name = "Spoke1"
  }
}

resource "aws_subnet" "spoke1_subnet" {
  availability_zone = "${var.primary_az}"
  vpc_id            = "${aws_vpc.spoke1_vpc.id}"
  cidr_block        = "${var.spoke1_subnet_cidr}"
  
  tags {
    Name = "Spoke1"
  }
}

###################################
###### Spoke-1 Security Group #####
###################################

resource "aws_security_group" "spoke1_security_group"{
  description = "Spoke1 Jump Server SG"
  vpc_id      = "${aws_vpc.spoke1_vpc.id}"

  # SSH access from My Home_IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["24.200.180.8/32"]
  } 

  # HTTP access from my Home_IP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["24.200.180.8/32"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 

        tags {
    Name        = "Spoke1 Jump Server SG"
  } 

}

####################################
##### Spoke2 VPC &Subnets  ########
####################################

resource "aws_vpc" "spoke2_vpc"{
  cidr_block       = "${var.spoke2_vpc_cidr}"
  instance_tenancy = "default"
      
  tags {
    Name = "Spoke2"
  }
}

resource "aws_subnet" "spoke2_subnet" {
  availability_zone = "${var.primary_az}"
  vpc_id            = "${aws_vpc.spoke2_vpc.id}"
  cidr_block        = "${var.spoke2_subnet_cidr}"
  
  tags {
    Name = "Spoke2"
  }
}

###################################
###### Spoke-2 Security Group #####
###################################

resource "aws_security_group" "spoke2_security_group"{
  description = "Spoke2 SG"
  vpc_id      = "${aws_vpc.spoke2_vpc.id}"

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

        tags {
    Name        = "Spoke2 SG"
  } 

}

####################################
###### Mgmt VPC &Subnets  ##########
####################################

resource "aws_vpc" "mgmt_vpc"{
  cidr_block       = "${var.mgmt_vpc_cidr}"
  instance_tenancy = "default"
      
  tags {
    Name = "Mgmt"
  }
}

resource "aws_subnet" "mgmt_subnet" {
  availability_zone = "${var.primary_az}"
  vpc_id            = "${aws_vpc.mgmt_vpc.id}"
  cidr_block        = "${var.mgmt_subnet_cidr}"
  
  tags {
    Name = "Mgmt Subnet"
  }
}

####################################
###### Internet Gateways  ##########
####################################

resource "aws_internet_gateway" "mgmt_igw" {
  vpc_id = "${aws_vpc.mgmt_vpc.id}"

  tags = {
    Name = "Mgmt-IGW"
  }
}

resource "aws_internet_gateway" "geocluster_igw" {
  vpc_id = "${aws_vpc.geocluster_vpc.id}"

  tags = {
    Name = "Geocluster-IGW"
  }
}

resource "aws_internet_gateway" "spoke1_igw" {
  vpc_id = "${aws_vpc.spoke1_vpc.id}"

  tags = {
    Name = "Spoke1-IGW"
  }

}


