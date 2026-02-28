# Terraform AWS EKS Cluster

A production-ready Terraform project that provisions an EKS (Kubernetes) cluster on AWS with a dedicated VPC.

## What This Creates

- **VPC** with public and private subnets across multiple Availability Zones
- **NAT Gateways** (one per AZ) for high availability
- **EKS Cluster** with control plane logging enabled
- **Managed Node Group** with auto-scaling
- **OIDC Provider** for IAM Roles for Service Accounts (IRSA)
- Proper **IAM roles and policies** for cluster and nodes

## Project Structure

```
terraform-aws-eks/
├── main.tf                        # Root module: providers + module calls
├── variables.tf                   # Input variables
├── outputs.tf                     # Output values
├── terraform.tfvars.example       # Example variable values
└── modules/
    ├── vpc/                       # VPC, subnets, NAT gateways, route tables
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── eks/                       # EKS cluster, node group, OIDC
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- [kubectl](https://kubernetes.io/docs/tasks/tools/) for interacting with the cluster

## Usage

### 1. Configure Variables

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your desired values
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Review the Plan

```bash
terraform plan
```

### 4. Apply

```bash
terraform apply
```

### 5. Connect to Your Cluster

After apply completes, run the output command to configure kubectl:

```bash
aws eks update-kubeconfig --region us-east-1 --name my-project-dev-eks
kubectl get nodes
```

## Estimated Cost

| Resource                  | Estimated Monthly Cost |
|---------------------------|------------------------|
| EKS Control Plane         | ~$73                   |
| 2x t3.medium worker nodes | ~$60                   |
| 3x NAT Gateways           | ~$100+                 |
| **Total (approx.)**       | **~$233+**             |

> To reduce costs in dev/test, reduce `availability_zones` to 1 (single NAT gateway) and use smaller instance types.

## Cleanup

```bash
terraform destroy
```
