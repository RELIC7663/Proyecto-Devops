# =============================================================================
# Terraform - Infraestructura local con Minikube
# Provider: kubernetes + helm
# =============================================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
}

# Configura el provider de Kubernetes usando el kubeconfig local (minikube)
provider "kubernetes" {
  config_path    = var.kubeconfig_path
  config_context = var.kube_context
}

provider "helm" {
  kubernetes {
    config_path    = var.kubeconfig_path
    config_context = var.kube_context
  }
}

# -----------------------------------------------------------------------------
# Recurso 1: Namespace staging
# -----------------------------------------------------------------------------
resource "kubernetes_namespace" "staging" {
  metadata {
    name = "staging"
    labels = {
      environment = "staging"
      managed-by  = "terraform"
    }
  }
}

# -----------------------------------------------------------------------------
# Recurso 2: Namespace prod
# -----------------------------------------------------------------------------
resource "kubernetes_namespace" "prod" {
  metadata {
    name = "prod"
    labels = {
      environment = "production"
      managed-by  = "terraform"
    }
  }
}

# -----------------------------------------------------------------------------
# Recurso 3: Helm release - kube-prometheus-stack (monitoring)
# -----------------------------------------------------------------------------
resource "helm_release" "prometheus_stack" {
  name             = "prom"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true
  version          = "61.7.0"

  set {
    name  = "grafana.adminPassword"
    value = var.grafana_admin_password
  }

  set {
    name  = "prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues"
    value = "false"
  }

  depends_on = [
    kubernetes_namespace.staging,
    kubernetes_namespace.prod
  ]
}
