# =============================================================================
# Backend de Terraform
# =============================================================================
# Para un entorno de laboratorio local, usamos el backend local.
# En un entorno cloud real se usaria un backend remoto (S3, GCS, Azure Blob).

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
