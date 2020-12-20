# Terraform Environment
Terraform v0.12.29 and AWS Provider version 3.22 

![alt text](https://github.com/etcheby/TGWHA/blob/master/TF-Environment.png)

# AWS Demo Environment
Terraform Script for Check Point Cloudguard TGW HA deployment - Recommended for demos or POCs. Assumes you're willing to deploy Mgmt in AWS. Tweak script accordingly should you have on-prem Mgmt. This template creates an AWS TGW environment with: 

* 2 spoke VPCs, Spoke 1 Jump instance, Spoke 2 private instance.
* 1 Check Point Mgmt VPC and Mgmt Instance, 
* 1 Cloudguard IaaS HA security VPC, 
* Relevant VPCs, Subnets RT, TGW attachments,TGW Route Tables 

# Architecture Diagram
![alt text](https://github.com/etcheby/TGWHA-Demo/blob/master/TGW-HA-Solution.png)

# Terrform Authentication & Provider & State File
In this example I'm using local credentials file in the provider.tf file. Change path to local credentials file accordingly as well as desired region. It's a best practice not to hardcode your AWS credentials in your script - Other Authentication options for the AWS Provider can be found under the Authentication Section of Terraform AWS Provider Documentation. 
* https://registry.terraform.io/providers/hashicorp/aws/latest/docs

![alt text](https://github.com/etcheby/TGWHA/blob/master/TF-Authentication.png)

It is also assumed that I'm using local backend for state file. Typical Production environment would require remote backend configuration which isn't covered here. 

The AWS Provider is downloaded locally as well. Central provider path isn't covered in this example. 

# Deployment Steps

1- Download the Official Check Point CFTs YAMLs from SK111013 & review accepted values for CFT parameters. 
2- Update the variables.tf
2- Run Terraform init
3- Terraform plan
4- Terraform apply

# Check Point TGW High Availability Admin Guide 
* https://sc1.checkpoint.com/documents/IaaS/WebAdminGuides/EN/CP_CloudGuard_for_AWS_Transit_Gateway_High_Availability/Default.htm

  Once Terraform template deployment is completed, follow steps from page 24/34 to configure the cluster object in Smart Console & Security Policy 

# Demo Video of TGW HA Solution (including Egress, E/W and Failover)

* https://youtu.be/dJfFHbJ4kVw

 
