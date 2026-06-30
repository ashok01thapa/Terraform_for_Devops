# Terraform for DevOps — Hands-On Repo

This repository is my personal learning playground for Terraform as a DevOps Engineer — covering basics through production-style patterns with real AWS infrastructure, including a full EKS (Kubernetes) cluster setup.

## Prerequisites

- Terraform >= 1.5.0 (recommended: 1.14.x)
- AWS CLI configured with valid credentials
- An AWS account (Free Tier works for most examples)

## Versions Used

| Tool | Version |
|------|---------|
| Terraform | >= 1.5.0 |
| AWS Provider | ~> 6.0 |
| EKS Module | ~> 21.0 |
| VPC Module | ~> 5.0 |

## Repository Structure

```
Terraform_for_Devops/
├── terraform-for-devops/      # EC2 + VPC basics project
│   ├── terraform.tf           # Provider config & version constraints
│   ├── variables.tf           # Input variables
│   ├── vpc.tf                 # VPC, subnet, security group
│   ├── ec2.tf                 # EC2 instance
│   ├── outputs.tf              # Output values
│   ├── providers.tf            # AWS provider region
│   └── install_nginx.sh        # EC2 user_data bootstrap script
│
├── remote-infra/               # Remote state backend
│   ├── terraform.tf            # Provider config
│   ├── providers.tf            # AWS provider region
│   ├── s3.tf                   # S3 bucket for tfstate (versioning & encryption)
│   └── dynamodb.tf             # DynamoDB table for state locking
│
├── terraform-modules-app/      # Reusable Modules example
│   ├── terraform.tf            # Provider version constraints
│   ├── providers.tf            # AWS provider region
│   ├── main.tf                 # Module composition
│   └── infra-app/               # The reusable module
│       ├── variables.tf         # Module inputs
│       ├── ec2.tf                # EC2 instances
│       ├── s3.tf                 # S3 bucket
│       └── dynamodb.tf           # DynamoDB table
│
└── terraform-eks/               # EKS Cluster
    ├── terraform.tf              # Provider config & version constraints
    ├── provider.tf                # Provider + locals
    ├── locals.tf                  # Shared naming/tagging conventions
    ├── vpc.tf                     # VPC module for EKS networking
    └── eks.tf                     # EKS cluster with managed node groups & add-ons
```

## What You'll Learn

| Concept | Where to Find It |
|---------|-------------------|
| Provider & version constraints | `terraform-for-devops/terraform.tf` |
| Variables | `terraform-for-devops/variables.tf` |
| VPC, Subnets, Security Groups | `terraform-for-devops/vpc.tf` |
| EC2 instances | `terraform-for-devops/ec2.tf` |
| user_data bootstrapping | `terraform-for-devops/ec2.tf` + `install_nginx.sh` |
| Outputs | `terraform-for-devops/outputs.tf` |
| Remote state backend (S3) | `remote-infra/s3.tf` |
| State locking (DynamoDB) | `remote-infra/dynamodb.tf` |
| Reusable modules | `terraform-modules-app/infra-app/` |
| Module composition | `terraform-modules-app/main.tf` |
| EKS cluster (managed node groups) | `terraform-eks/eks.tf` |
| VPC for Kubernetes | `terraform-eks/vpc.tf` |
| EKS add-ons (vpc-cni, kube-proxy, coredns) | `terraform-eks/eks.tf` |
| Locals for naming/tagging | `terraform-eks/locals.tf` |

## Terraform Commands — Complete Guide

### 1. Setup & Initialization

**Install Terraform (Linux/Ubuntu)**

```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Verify installation
terraform -v
```

**Install Terraform (macOS)**

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

**Initialize Terraform**

```bash
terraform init
```
- Downloads provider plugins
- Sets up the working directory

### 2. Core Commands

```bash
terraform fmt                     # Format code to standard style
terraform validate                # Validate syntax and configuration
terraform plan                    # Preview changes without applying
terraform apply                   # Create/update infrastructure
terraform apply -auto-approve     # Apply without confirmation
terraform destroy                 # Destroy all managed resources
terraform destroy -auto-approve   # Destroy without confirmation
```

### 3. Managing State

```bash
terraform state list              # List all managed resources
terraform show                    # Show detailed resource info
terraform state mv <src> <dest>   # Move resource in state
terraform state rm <resource>     # Remove from state (not from cloud)
```

**Remote Backend (S3 + DynamoDB for locking)** — see `remote-infra/`

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
```

### 4. Variables & Outputs

```bash
terraform apply -var="instance_type=t3.small"   # Pass variable via CLI
terraform output                                 # Show all outputs
terraform output ec2_public_ip                    # Show specific output
```

### 5. Workspaces

```bash
terraform workspace new dev       # Create workspace
terraform workspace select prod   # Switch workspace
terraform workspace list          # List all workspaces
```

### 6. Debugging

```bash
export TF_LOG=DEBUG
terraform apply 2>&1 | tee debug.log
```

## Usage

Each project folder is self-contained:

```bash
cd <project-folder>
terraform init
terraform plan
terraform apply
```

To tear down resources and avoid AWS charges:

```bash
terraform destroy
```

> ⚠️ **Note:** State files, `.terraform/` directories, and `.tfvars` files are intentionally excluded via `.gitignore` and are not included in this repo. Run `terraform init` to re-download providers.

## Learning Journey

1. **Basics** → `terraform-for-devops/` — single EC2 instance with a custom VPC
2. **State management** → `remote-infra/` — remote backend with S3 + DynamoDB
3. **Modularity** → `terraform-modules-app/` — breaking infrastructure into reusable modules
4. **Production patterns** → `terraform-eks/` — managed Kubernetes cluster with EKS

## Connect

If you have feedback or suggestions, feel free to open an issue or reach out!

⭐ If you find this useful for your own Terraform learning, consider starring the repo.
