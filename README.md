# TGWHA
Terraform Script for Check Point Cloudguard TGW HA deployment - Recommended for demos or POCs.
Assumes you're willing to deploy Mgmt in AWS. Tweak script accordingly should you have on-prem Mgmt. 

Phase#1 - Completed 08/05/2020
Builds an AWS TGW environment with 2 spoke VPCs, 1 Check Point Mgmt VPC and Instance, 1 Cloudguard IaaS HA security VPC, relevant VPCs&subnets RT, 
TGW attachments,TGW Route Tables
Architecture Diagram of deployment can be found --> https://github.com/etcheby/TGWHA/blob/master/TGW-HA-Solution.png

Phase#2 - To be completed by 09/01/2020 or earlier.
Will add Check Security Mgmt rules to test E/W and Egress inspection, based on Check Point TF provider resources
