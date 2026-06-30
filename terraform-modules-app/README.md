# Terraform Reusable Modules — Multi-Environment AWS Infra

Deploys the same infrastructure (EC2, S3, DynamoDB) across **three environments** (`dev`, `stg`, `prd`) using a single reusable Terraform module.

Steps to implement:

* Set Up Terraform
   * Install Terraform: Make sure Terraform is installed on your system. If not, [click here](https://developer.hashicorp.com/terraform/install) to install.
* In the current directory you will see `main.tf`, `providers.tf`, `terraform.tf`, and the reusable module in `infra-app/`
* Initialize the terraform project

```
terraform init
```

* Validate the configuration

```
terraform validate
```

* Preview the infrastructure changes

```
terraform plan
```

* Apply the changes

```
terraform apply
```

* To destroy the infrastructure when done

```
terraform destroy
```

## Structure

```
terraform-modules-app/
├── main.tf          # Calls infra-app module 3x (dev, stg, prd)
├── providers.tf      # AWS provider (us-east-2)
├── terraform.tf       # Provider version constraints
└── infra-app/          # Reusable module
    ├── variables.tf
    ├── ec2.tf
    ├── s3.tf
    └── dynamodb.tf
```

## Environments

| Environment | Instances | Instance Type |
|-------------|-----------|----------------|
| `dev` | 1 | `t2.micro` |
| `stg` | 1 | `t2.small` |
| `prd` | 2 | `t2.medium` |

Each environment gets its own EC2 instance(s), S3 bucket, and DynamoDB table, all prefixed with the environment name (e.g. `dev-infra-app-bucket`, `prd-infra-app-table`).

## What the Module Creates

* EC2 instance(s) with a security group (SSH + HTTP open) and key pair
* S3 bucket
* DynamoDB table (`PAY_PER_REQUEST` billing)

## Keeping Keys & Secrets Safe

* Generate your own key pair before applying, and never commit the private key:

```
ssh-keygen -t rsa -b 4096 -f terra-key-ec2
```

* Add to `.gitignore`:

```
terra-key-ec2
*.pem
```
