SAP on AWS - a sample project
==============================
This is a sample project where we run SAP workload on AWS to learn more on how
things are done in the cloud. To use it, you need to obtain a copy of SAP HANA
Express which has a free trial to be used for learning.

This project is built using Terraform based on CloudFormation templates and
resources generated by AWS Launch Wizard. To go through the same process, deploy
tag `v1` from here first and use all the resources generated by this project in
Launch Wizard.

Tag `final` of this repository will contain the full setup of SAP based on the
resources from Launch Wizard.

Currently the project contains a simple VPC setup with four subnets, two public,
two private, a single NAT instance based on my other project, S3 buckets for
HANA installation files and for CloudFormation templates and SSH key pair to use
for SAP instances.