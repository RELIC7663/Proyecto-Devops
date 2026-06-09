# Proyecto DevOps — Spring PetClinic

[![CI](https://github.com/RELIC7663/Proyecto-Devops/actions/workflows/ci.yml/badge.svg)](https://github.com/RELIC7663/Proyecto-Devops/actions/workflows/ci.yml)
[![CD](https://github.com/RELIC7663/Proyecto-Devops/actions/workflows/cd.yml/badge.svg)](https://github.com/RELIC7663/Proyecto-Devops/actions/workflows/cd.yml)

Taller DevOps de 7 días aplicado sobre **Spring PetClinic 4.0** (Spring Boot 4.0.3). Implementa un ciclo completo de CI/CD, contenedorización, orquestación con Kubernetes, observabilidad y DevSecOps.

## Arquitectura

```
┌──────────────┐     push      ┌──────────────┐     image      ┌──────────────┐
│   Developer  │ ────────────► │  GitHub CI   │ ─────────────► │    GHCR      │
└──────────────┘               │  (Actions)   │                │  (Registry)  │
                               └──────┬───────┘                └──────┬───────┘
                                      │ trigger CD                    │ pull
                                      ▼                               ▼
                               ┌──────────────┐               ┌──────────────┐
                               │  Self-Hosted │ ─────────────► │  Minikube    │
                               │   Runner     │  kubectl apply │  K8s Cluster │
                               └──────────────┘               └──────┬───────┘
                                                                      │
                                                        ┌─────────────┼─────────────┐
                                                        ▼             ▼             ▼
                                                   ┌─────────┐  ┌─────────┐  ┌───────────┐
                                                   │ staging │  │  prod   │  │ monitoring│
                                                   │   ns    │  │   ns    │  │    ns     │
                                                   └─────────┘  └─────────┘  └───────────┘
```

## Tecnologías

| Categoría | Herramienta |
|---|---|
| Aplicación | Spring Boot 4.0.3 / Java 17 |
| Build | Maven 3.x + JaCoCo |
| CI/CD | GitHub Actions |
| Contenedor | Docker (multi-stage) |
| Registry | GitHub Container Registry (GHCR) |
| Orquestación | Kubernetes (Minikube) |
| IaC | Terraform (providers: kubernetes, helm) |
| Monitoreo | Prometheus + Grafana (kube-prometheus-stack) |
| Seguridad | Trivy, Gitleaks, OWASP ZAP |
| Métricas | Micrometer + Prometheus registry |

## Cómo ejecutar localmente

### Prerrequisitos

- JDK 17+
- Maven 3.9+
- Docker Desktop
- Minikube
- kubectl
- Terraform >= 1.5

### Ejecutar la aplicación

```bash
cd app
mvn clean verify
mvn spring-boot:run
```

### Verificar endpoints

```bash
# Health
curl http://localhost:8080/actuator/health

# Kubernetes probes
curl http://localhost:8080/actuator/health/readiness
curl http://localhost:8080/actuator/health/liveness

# Prometheus metrics
curl http://localhost:8080/actuator/prometheus
```

### Ejecutar con Docker

```bash
cd app
docker build -t spring-petclinic-devops .
docker run -p 8080:8080 spring-petclinic-devops
```

## Pipeline CI/CD

- **CI** (`ci.yml`): Build → Tests → Cobertura JaCoCo ≥80% → Gitleaks → Trivy FS → SonarCloud → Docker Build+Push a GHCR → Trivy Image Scan.
- **CD** (`cd.yml`): Staging automático → Smoke test → Producción con approval manual.

## Kubernetes

Manifiestos en `k8s/`:

| Recurso | Archivo | Descripción |
|---|---|---|
| Namespace | `namespace.yaml` | `staging` y `prod` |
| Deployment | `deployment.yaml` | 2 réplicas, rolling update, readiness/liveness probes, resource limits |
| Service | `service.yaml` | ClusterIP en puerto 80 → 8080 |
| HPA | `hpa.yaml` | Auto-escalado 2-10 pods al 60% CPU |
| PDB | `pdb.yaml` | Mínimo 1 pod disponible |
| ConfigMap | `configmap.yaml` | Variables de entorno de configuración |
| Secret | `secret.yaml` | Credenciales de base de datos |
| Ingress | `ingress.yaml` | Acceso externo vía nginx |

## Terraform

Infraestructura local gestionada con providers `kubernetes` y `helm`:

1. Namespace `staging`
2. Namespace `prod`
3. Helm release `kube-prometheus-stack`

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## Observabilidad

- **Prometheus**: Recolecta métricas de la app vía `/actuator/prometheus` (ServiceMonitor).
- **Grafana**: Dashboard SLO con 4 paneles: Request Rate, Error Rate, P99 Latency, Pod Count.
- **SLI/SLO**: Disponibilidad 99.9%.

## DevSecOps

- **Trivy**: Escaneo de filesystem y de imagen Docker en CI.
- **Gitleaks**: Detección de secretos filtrados en el código.
- **OWASP ZAP**: Baseline scan contra la aplicación desplegada.
- **Secrets management**: Kubernetes Secrets + GitHub Secrets.

## Métricas DORA

Ver detalle en [`docs/dora-metrics.md`](docs/dora-metrics.md).

- Deployment Frequency
- Lead Time for Changes
- Change Failure Rate
- MTTR (Mean Time to Recovery)

## Evidencias

Las capturas de pantalla y evidencias se encuentran en [`docs/evidencias/`](docs/evidencias/).

El informe IEEE (10-15 páginas) se encuentra en [`docs/informe/`](docs/informe/).

El post-mortem blameless del incidente simulado está en [`docs/postmortem.md`](docs/postmortem.md).
