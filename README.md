# WebSocket Project using Terraform and AWS
This project provisions a simple WebSocket environment on AWS using Terraform. It deploys two EC2 instances in the us-east-1 region with Amazon Linux 2 AMIs:

# WebSocket Server: 
An Amazon Linux 2 instance running a WebSocket server configured via user data.

# WebSocket Client: 
Another Amazon Linux 2 instance running a client configured to connect to the server using its private IP.

# Key Features
Infrastructure as code using Terraform.

SSH key pair imported from your local public key for secure access.

Security group allows inbound SSH (port 22) and WebSocket traffic (port 8080) from anywhere.

Automated instance setup with user data scripts.

Outputs public and private IPs of instances for easy connection and testing.

# Requirements
Terraform installed and configured

AWS CLI credentials set up

**SSH public key file available at L:/terraform/awskey/publickey.pub (update path if needed)**

# User data scripts:

server_user_data.sh — for server setup

client_user_data.sh.tpl — for client setup with dynamic server IP

# How to Deploy
Clone this repository.

Customize the user data scripts as needed.

# Run the Terraform commands:

*bash*

*terraform init*

*terraform plan*

*terraform apply*

**Use the output IP addresses to SSH into the instances or connect your WebSocket clients**
