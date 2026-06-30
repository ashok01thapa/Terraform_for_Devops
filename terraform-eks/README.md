# AWS EKS Cluster Deployment Using Terraform

Steps to implement:

* Set Up Terraform
   * Install Terraform: Make sure Terraform is installed on your system. If not, [click here](https://developer.hashicorp.com/terraform/install) to install.
* In the current directory you will see all the `.tf` files (`terraform.tf`, `provider.tf`, `locals.tf`, `vpc.tf`, `eks.tf`)
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

* Update your kubeconfig file to connect to the EKS cluster

```
aws eks --region us-east-2 update-kubeconfig --name tws-eks-cluster
```

* Verify the cluster connection

```
kubectl get nodes
```

* To destroy the infrastructure when done

```
terraform destroy
```

## Cluster Details

| Setting | Value |
|---------|-------|
| Cluster Name | `tws-eks-cluster` |
| Kubernetes Version | `1.33` |
| Region | `us-east-2` |
| Environment | `dev` |
| Node Group | `tws-cluster-ng` (t2.medium, SPOT, min 2 / desired 2 / max 3) |
| Add-ons | vpc-cni, kube-proxy, coredns |
| VPC CIDR | `10.0.0.0/16` |
| Availability Zones | `us-east-2a`, `us-east-2b` |
| Private Subnets | `10.0.1.0/24`, `10.0.2.0/24` |
| Public Subnets | `10.0.101.0/24`, `10.0.102.0/24` |
| Intra Subnets | `10.0.5.0/24`, `10.0.6.0/24` |
