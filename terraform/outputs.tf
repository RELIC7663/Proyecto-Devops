output "vpc_id" {
  description = "VPC ID created for the project."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs."
  value       = aws_subnet.public[*].id
}

output "app_security_group_id" {
  description = "Security group ID for the application tier."
  value       = aws_security_group.app.id
}

output "db_endpoint" {
  description = "RDS PostgreSQL endpoint."
  value       = aws_db_instance.postgres.endpoint
}

output "db_password" {
  description = "Generated RDS password. Store it in a secret manager."
  value       = random_password.db.result
  sensitive   = true
}

output "artifact_bucket_name" {
  description = "S3 bucket for build or evidence artifacts."
  value       = aws_s3_bucket.artifacts.bucket
}
