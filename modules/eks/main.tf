module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.10.0"

  name = "${var.project_name}-${var.environment}-eks"
  kubernetes_version = var.kubernetes_version
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  control_plane_subnet_ids = var.control_plane_subnet_ids

  endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  addons = {
    coredns = {}
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
    eks-pod-identity-agent = {
      before_compute = true
    }
  }

  eks_managed_node_groups = {
    demo-app = {
      ami_type = "AL2023_x86_64_STANDARD"
      instance_types = var.node_instance_types

      min_size = var.node_min_size
      max_size = var.node_max_size
      desired_size = var.node_desired_size
    }
  }
 
  tags = {
    Environment = var.environment
    Terraform = "true"
  }
}







