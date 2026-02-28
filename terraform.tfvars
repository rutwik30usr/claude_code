# Rename this file to terraform.tfvars and update with your values

aws_region   = "us-east-1"
project_name = "my-project"
environment  = "dev"

vpc_cidr           = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

kubernetes_version  = "1.29"
node_instance_types = ["t3.medium"]
node_desired_size   = 2
node_min_size       = 1
node_max_size       = 5
