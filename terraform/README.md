# Terraform IaC

This folder provisions the cloud foundation for the DevOps workshop:

- VPC, public subnets, route table and internet gateway.
- Application and database security groups.
- PostgreSQL RDS instance.
- S3 bucket for build/evidence artifacts with versioning, encryption and public access blocked.
- Remote state through the S3 backend and DynamoDB locking.

## Remote state

Create the state bucket and lock table once, then copy `backend.hcl.example` to `backend.hcl` and set the real names:

```bash
terraform init -backend-config=backend.hcl
```

## Commands

```bash
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

The generated database password is a sensitive output. Store it in a secret manager or in Kubernetes as a secret, never in plain text in the repository.
