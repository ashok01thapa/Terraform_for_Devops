
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
aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>
```

* Verify the cluster connection

```
kubectl get nodes
```

* To destroy the infrastructure when done

```
terraform destroy
```
