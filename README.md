# AWS Highly Available Multi-Tier Architecture 


This repository demonstrates the automated provisioning and configuration of a highly available, 3-tier web architecture on AWS using **Terraform** (Infrastructure as Code) and **Ansible** (Configuration Management).

## Project Overview

The goal of this project is to move away from manual AWS console clicks and deploy a production-ready, fault-tolerant infrastructure entirely through code. 

The architecture includes a custom Virtual Private Cloud (VPC), public and private subnets spanning two Availability Zones, an Auto Scaling Group of EC2 web servers behind an Application Load Balancer, and an isolated Multi-AZ RDS MySQL database. Once the infrastructure is provisioned, Ansible dynamically configures the EC2 instances to serve a Node.js web application.



## Architecture Design

*(Insert your architecture diagram here. You can use tools like Draw.io or Excalidraw to map out the VPC, ALB, ASG, and RDS.)*

![Architecture Diagram](./images/architecture-diagram.png)

### Core Components:
* **Networking Tier:** Custom VPC, Internet Gateway, NAT Gateway (Single AZ for cost optimization), Public & Private Subnets.
* **Compute Tier:** `t3.micro` Amazon Linux 2023 EC2 instances, Application Load Balancer (ALB), Auto Scaling Group (ASG).
* **Database Tier:** `db.t3.micro` Multi-AZ MySQL RDS instance (isolated in private subnets).

---

## Repository Structure

```text
aws-multi-tier-iac/
├── terraform/
│   ├── providers.tf      # AWS provider and region config
│   ├── main.tf           # VPC and networking modules
│   ├── compute.tf        # Security Groups, ALB, ASG, Launch Templates
│   └── database.tf       # RDS instance and DB subnet groups
├── ansible/
│   ├── inventory_aws_ec2.yml  # Dynamic inventory plugin configuration
│   └── playbook.yml      # Installs Node.js and starts the web server
├── .gitignore            # Ignores Terraform state files and sensitive data
└── README.md


### Prerequisites
To deploy this project, you will need:

AWS CLI installed and configured with your IAM credentials.

Terraform installed.

Ansible installed (along with boto3 and the amazon.aws collection).

### Deployment Instructions
Phase 1: Provision Infrastructure with Terraform
Navigate to the terraform directory: cd terraform

Initialize the working directory and download provider plugins:
terraform init

Review the execution plan:
terraform plan

Deploy the infrastructure:
terraform apply -auto-approve

Phase 2: Configure Servers with Ansible
Navigate to the ansible directory:
cd ../ansible

Ensure you have the required AWS collections:
ansible-galaxy collection install amazon.aws
pip install boto3

Run the playbook using the dynamic inventory:
ansible-playbook -i inventory_aws_ec2.yml playbook.yml

### AUTHOR: PHILIP LUCKY
   EMAIL: philipslucky24@gmail.com
