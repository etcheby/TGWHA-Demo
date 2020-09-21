# TGWHA - Terraform v0.11.14+ with AWS Provider 3.7
Terraform Script for Check Point Cloudguard TGW HA deployment - Recommended for demos or POCs.
Assumes you're willing to deploy Mgmt in AWS. Tweak script accordingly should you have on-prem Mgmt.

# AWS Environment
This template creates an AWS TGW environment with 2 spoke VPCs, 1 Check Point Mgmt VPC and Instance, 1 Cloudguard IaaS HA security VPC, relevant VPCs&subnets RT, 
TGW attachments,TGW Route Tables, Spoke 1 Jump instance, Spoke 2 private instance. 
Architecture Diagram
![alt text](https://github.com/etcheby/TGWHA/blob/master/TGW-HA-Solution.png)

# Authentication
Many options are possible per Terraform documentation the provider.tf file I'm using credentials text file. 

# Check Point TGW High Availability Admin Guide https://sc1.checkpoint.com/documents/IaaS/WebAdminGuides/EN/CP_CloudGuard_for_AWS_Transit_Gateway_High_Availability/Default.htm
Continue from page 24/34 to configure the cluster object in Smart Console. 
 
