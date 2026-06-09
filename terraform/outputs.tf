# =============================================================================
# Outputs de Terraform
# =============================================================================

output "staging_namespace" {
  description = "Nombre del namespace de staging"
  value       = kubernetes_namespace.staging.metadata[0].name
}

output "prod_namespace" {
  description = "Nombre del namespace de produccion"
  value       = kubernetes_namespace.prod.metadata[0].name
}

output "prometheus_release_status" {
  description = "Estado del release de Helm de Prometheus"
  value       = helm_release.prometheus_stack.status
}

output "grafana_url" {
  description = "URL local de Grafana (requiere port-forward)"
  value       = "kubectl port-forward svc/prom-grafana 3000:80 -n monitoring"
}
