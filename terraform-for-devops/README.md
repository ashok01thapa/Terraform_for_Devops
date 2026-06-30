# AWS EC2 Deployment Using Terraform

Provisions EC2 instances on AWS with a custom security group, SSH key pair, and Nginx bootstrap script.

Steps to implement:

* Set Up Terraform
   * Install Terraform: Make sure Terraform is installed on your system. If not, [click here](https://developer.hashicorp.com/terraform/install) to install.
* In the current directory you will see all the `.tf` files (`terraform.tf`, `providers.tf`, `variables.tf`, `vpc.tf`, `ec2.tf`, `outputs.tf`)
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

* Get the public IP(s) of the created instance(s)

```
terraform output ec2_public_ip
```

* SSH into the instance

```
ssh -i terra-key-ec2 ec2-user@<public-ip>
```

* To destroy the infrastructure when done

```
terraform destroy
```

## What Gets Created

| Resource | Details |
|----------|---------|
| Security Group | `automate-sg` — SSH (22), HTTP (80), Flask app (8000) inbound; all outbound |
| EC2 Instances | `t2.micro` and `t2.medium` (via `for_each`) |
| Key Pair | SSH key pair for secure login |
| Root Volume | `gp3`, 20GB in prod, configurable otherwise |
| Bootstrap | `install_nginx.sh` runs on first boot |
| Region | `us-east-2` |

## Keeping Keys & Secrets Safe

This project uses an SSH key pair for EC2 login. To avoid leaking secrets:

* **Never commit your private key** (`terra-key-ec2`) — only the public key (`terra-key-ec2.pub`) is referenced by Terraform and safe to keep locally.
* Generate your own key pair before running `terraform apply`:

```
ssh-keygen -t rsa -b 4096 -f terra-key-ec2
```

* Add both private key files to `.gitignore`:

```
terra-key-ec2
*.pem
```

* State is stored remotely in S3 (`tws-junoon-state-bucket`) with DynamoDB locking (`tws-junoon-state-table`), so no `.tfstate` files are committed either.
