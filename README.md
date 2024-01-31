# demo-4-duplo
TF artifacts for demo build

# Terraform AWS/EKS or GCP/GKE Kubernetes Cluster with Web Application

This Terraform project deploys a Kubernetes cluster with a web application on either AWS with EKS or GCP with GKE.

## AWS/EKS Configuration (main.tf)

### Placeholder Variables:

- `region`: The AWS region where the EKS cluster will be deployed.
- `subnet_ids`: The list of subnet IDs where the EKS nodes will be launched.
- `vpc_id`: The ID of the VPC where the EKS cluster will be created.
- `cluster_name`: The name of the EKS cluster.
- `cluster_version`: The desired Kubernetes version for the EKS cluster.
- `desired_capacity`, `min_capacity`, `max_capacity`: Node group capacity configuration.
- `instance_type`: The EC2 instance type for the EKS nodes.
- `key_name`: The name of your EC2 key pair.

## GCP/GKE Configuration (main.tf)

### Placeholder Variables:

- `project`: The GCP project ID.
- `region`: The GCP region where the GKE cluster will be deployed.
- `name`: The name of the GKE cluster.
- `initial_node_count`: The initial number of nodes in the GKE cluster.
- `machine_type`: The machine type for the GKE nodes.
- `webapp_container_image`: The container image for the web application.

## How to Identify Placeholder Variables:

Look for lines in the Terraform code containing placeholder values enclosed in double asterisks (`**`). Replace these values with your actual configuration.

```hcl
provider "aws" {
  region = "**<desired-region>**"
}

resource "module" "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "**my-eks-cluster**"
  subnets         = ["subnet-xxxxxxxxxxxxxxxxx", "subnet-yyyyyyyyyyyyyyyyy"]
  vpc_id          = "**vpc-xxxxxxxxxxxxxxxxx**"
  cluster_version = "**1.21**"

  node_groups = {
    eks_nodes = {
      desired_capacity = **2**
      max_capacity     = **3**
      min_capacity     = **1**

      instance_type = "**t2.small**"
      key_name      = "**your-key-pair-name**"
    }
  }
}

