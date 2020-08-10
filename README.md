# TGWHA - Terraform v0.11.14 or above
Terraform Script for Check Point Cloudguard TGW HA deployment - Recommended for demos or POCs.
Assumes you're willing to deploy Mgmt in AWS. Tweak script accordingly should you have on-prem Mgmt. 

# Phase#1 - Completed 08/05/2020
Builds an AWS TGW environment with 2 spoke VPCs, 1 Check Point Mgmt VPC and Instance, 1 Cloudguard IaaS HA security VPC, relevant VPCs&subnets RT, 
TGW attachments,TGW Route Tables, Spoke 1 Jump instance, Spoke 2 private instance. 
Architecture Diagram --> https://github.com/etcheby/TGWHA/blob/master/TGW-HA-Solution.png

# Check Point TGW High Availability Admin Guide https://sc1.checkpoint.com/documents/IaaS/WebAdminGuides/EN/CP_CloudGuard_for_AWS_Transit_Gateway_High_Availability/Default.htm
Continue from page 24/34 to configure the cluster object in Smart Console. 

# Phase#2 - To be completed by 09/01/2020 or earlier.
Will add mgmt_cli commands to create Cluster Object, Security Mgmt rules to test E/W and Egress inspection. 
