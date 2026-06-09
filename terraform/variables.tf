# =============================================================================
# Variables de Terraform
# =============================================================================

variable "kubeconfig_path" {
  description = "Ruta al archivo kubeconfig para conectarse al cluster"
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context" {
  description = "Contexto de Kubernetes a utilizar (ej. minikube)"
  type        = string
  default     = "minikube"
}

variable "grafana_admin_password" {
  description = "Password del admin de Grafana"
  type        = string
  sensitive   = true
  default     = "prom-operator"
}
