# Terraform Remote State Backend (S3 + DynamoDB)

Provisions the S3 bucket and DynamoDB table used as a remote backend for storing Terraform state and enabling state locking across the other projects in this repo.

Steps to implement:

* Set Up Terraform
   * Install Terraform: Make sure Terraform is installed on your system. If not, [click here](https://developer.hashicorp.com/terraform/install) to install.
* In the current directory you will see all the `.tf` files (`terraform.tf`, `providers.tf`, `s3.tf`, `dynamodb.tf`)
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

## What Gets Created

| Resource | Name | Purpose |
|----------|------|---------|
| S3 Bucket | `tws-junoon-state-bucket` | Stores Terraform state files |
| DynamoDB Table | `tws-junoon-state-table` | Locks state during apply to prevent conflicts (hash key: `LockID`) |
| Region | `us-east-2` | |

## Using This Backend in Other Projects

Once applied, point any other Terraform project's backend config at these resources:

```hcl
terraform {
  backend "s3" {
    bucket         = "tws-junoon-state-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "tws-junoon-state-table"
  }
}
```

> ⚠️ **Apply this project first**, before running `terraform init` on any other project in this repo that references this backend — the bucket and table must exist beforehand.
