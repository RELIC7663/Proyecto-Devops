variable "project_name" {
  description = "Project name used for resource names and tags."
  type        = string
  default     = "spring-petclinic-devops"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "staging"
}

variable "aws_region" {
  description = "AWS region where resources are created."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the application VPC."
  type        = string
  default     = "10.40.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
  default     = ["10.40.1.0/24", "10.40.2.0/24"]
}

variable "db_instance_class" {
  description = "RDS instance class for the lab database."
  type        = string
  default     = "db.t4g.micro"
}

variable "db_allocated_storage" {
  description = "Allocated RDS storage in GB."
  type        = number
  default     = 20
}
