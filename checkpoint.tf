# Deploy Check Point Management cloudformation template - sk130372

resource "aws_cloudformation_stack" "mgmt_CF_stack" {
  name = "TGW-Mgmt"

  parameters {
    VPC                     = "${aws_vpc.mgmt_vpc.id}"
    Subnet                  = "${aws_subnet.mgmt_subnet.id}"
    Name                    = "TGW-Mgmt"
    InstanceType            = "${var.mgmt_instance_type}"
    Version                 = "${var.cpversion}-BYOL"
    KeyName                 = "${var.key_name}"
    PasswordHash            = "${var.password_hash}"
    Shell                   = "/bin/bash"
    Permissions             = "Create with read-write permissions"
}

  template_url        = "https://s3.amazonaws.com/CloudFormationTemplate/management.json"
  capabilities        = ["CAPABILITY_IAM"]
  disable_rollback    = true
  timeout_in_minutes  = 25
}

# Deploy Check Point Geo-Cluster cloudformation template - (existing VPC) 
# From SK111013, download template 9 YAML to review which parameters you'd like to customize,.  

resource "aws_cloudformation_stack" "checkpoint_geocluster_stack" {
  name = "Geocluster"

  parameters {
    VPC                     = "${aws_vpc.geocluster_vpc.id}"
    PublicSubnetA           = "${aws_subnet.public_subnet1.id}"
    PublicSubnetB           = "${aws_subnet.public_subnet2.id}"
    PrivateSubnetA          = "${aws_subnet.private1.id}"
    PrivateSubnetB          = "${aws_subnet.private2.id}"
    TgwHASubnetA            = "${aws_subnet.tgw_subnet1.id}"
    TgwHASubnetB            = "${aws_subnet.tgw_subnet2.id}"
    InstanceType            = "${var.gateway_instance_type}"
    KeyName                 = "${var.key_name}"
    License                 = "${var.cpversion}-BYOL"
    PasswordHash            = "${var.password_hash}"
    Shell                   = "/bin/bash"
    SICKey                  = "vpn123vpn123"
    EnableInstanceConnect   = "true"
}

  template_url        = "https://s3.amazonaws.com/CloudFormationTemplate/checkpoint-tgw-ha.yaml"
  capabilities        = ["CAPABILITY_IAM"]
  disable_rollback    = true
  timeout_in_minutes  = 25
}