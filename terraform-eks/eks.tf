# cloud controller manager -> control plane

module "eks" {

    # import the module template
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 21.0"

    # cluster info (control plane)
    name               = local.name
    kubernetes_version = "1.33"
    endpoint_public_access = true

    vpc_id     = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets

      cluster_addons = {
        vpc-cni = {
          most_recent = true
        }
        kube-proxy = {
          most_recent = true
        }
        coredns = {
          most_recent = true
        }
      }


    # control plane network
    control_plane_subnet_ids = module.vpc.intra_subnets

    
    # managing nodes in the cluster
    eks_managed_node_groups = {

      tws-cluster-ng = {

        instance_types = ["t2.medium"]
        attach_primary_security_group = true

        min_size     = 2
        max_size     = 3
        desired_size = 2

        capacity_type = "SPOT"

      }
    }

  tags = {
    Environment = local.env
    Terraform   = "true"
  }
}