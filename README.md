# Deploying an EC2 Instance with Terraform

This project shows you how to use Terraform to provision an EC2 instance on AWS. It is structured to be beginner-friendly, with each file serving a clear and specific purpose.

---

## What is Terraform?

Terraform is an open-source Infrastructure as Code (IaC) tool made by HashiCorp. Instead of clicking through the AWS console to create resources, you write configuration files that describe what you want, and Terraform creates it for you. This makes your infrastructure repeatable, version-controlled, and easy to share.

---

## Project Structure

```
.
├── main.tf            # Core infrastructure definition
├── variables.tf       # Input variable declarations
├── outputs.tf         # Values to display after deployment
├── terraform.tfvars   # Your actual variable values
└── .gitignore         # Files to exclude from version control
```

---

## File Breakdown

### `main.tf`

This is the heart of the project. It contains three blocks:

**terraform block**
Declares the required Terraform version and the AWS provider plugin that Terraform needs to download.

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3.0"
}
```

**provider block**
Tells Terraform which AWS region to deploy resources into. The value comes from a variable so it can be easily changed.

```hcl
provider "aws" {
  region = var.aws_region
}
```

**resource block**
This is where the EC2 instance is actually defined. `aws_instance` is the resource type, and `main` is the local name we give it. The `ami` is the machine image (operating system), and `instance_type` defines the hardware size.

```hcl
resource "aws_instance" "main" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name        = var.instance_name
    Environment = var.environment
  }
}
```

---

### `variables.tf`

Variables make your configuration reusable. Instead of hardcoding values like the region or instance type directly in `main.tf`, you declare them here with a description, type, and optional default value.

```hcl
variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}
```

Each variable can be overridden without touching the core configuration files. This is important for teams where different environments (dev, staging, prod) need different values.

---

### `outputs.tf`

After Terraform creates your infrastructure, outputs let you see key information about what was created — like the instance ID or its public IP address. Think of them as the "return values" of your configuration.

```hcl
output "public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.main.public_ip
}
```

---

### `terraform.tfvars`

This file is where you set the actual values for your variables. Terraform automatically loads this file when you run a command. You can change values here without modifying any other file.

```hcl
aws_region    = "us-east-1"
instance_type = "t3.micro"
instance_name = "my-ec2-instance"
environment   = "dev"
```

> **Note:** Never commit sensitive values (like secrets or passwords) to this file. Use environment variables or a secrets manager instead.

---

### `.gitignore`

This file tells Git which files to ignore. The most important ones are:

- `.terraform/` — the folder Terraform uses to store downloaded plugins (large, auto-generated)
- `terraform.tfstate` — contains the current state of your infrastructure (can contain sensitive data)
- `terraform.tfstate.backup` — a backup of the previous state file

---

## Prerequisites

Before running this project, make sure you have:

1. [Terraform installed](https://developer.hashicorp.com/terraform/downloads) (version 1.3.0 or higher)
2. An AWS account
3. AWS credentials configured on your machine:
   - Via the AWS CLI: `aws configure`
   - Or by setting environment variables: `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`

---

## How to Deploy

Follow these steps in order:

**1. Initialize Terraform**
Downloads the AWS provider plugin and sets up the working directory.
```bash
terraform init
```

**2. Preview the changes**
Shows you exactly what Terraform is going to create before it does anything.
```bash
terraform plan
```

**3. Apply the configuration**
Creates the EC2 instance on AWS. You will be prompted to type `yes` to confirm.
```bash
terraform apply
```

Once complete, Terraform will print the outputs — including the instance ID and public IP.

---

## How to Destroy

When you are done and want to delete everything Terraform created, run:

```bash
terraform destroy
```

This will remove the EC2 instance from AWS. You will be prompted to confirm.

---

## Key Concepts Summary

| Concept | What it means |
|---|---|
| Provider | The cloud platform Terraform talks to (AWS in this case) |
| Resource | A piece of infrastructure to create (e.g. an EC2 instance) |
| Variable | A configurable input value |
| Output | A value displayed after deployment |
| State file | Terraform's record of what it has created |
| AMI | Amazon Machine Image — the OS template for your instance |

---

## Want to Go Further?

Here are some things you can add to extend this project:

- A **security group** to control inbound/outbound traffic
- A **key pair** to enable SSH access to the instance
- A **VPC** for network isolation
- **Remote state** using an S3 bucket so your team shares the same state file
