# Informe de Arquitectura y Prácticas DevOps
**Taller Integrador de 7 días - Spring PetClinic**

## 1. Resumen
Este informe detalla la implementación de un ciclo de vida completo de DevOps para la aplicación Spring PetClinic, cubriendo integración y despliegue continuo (CI/CD), infraestructura como código (IaC), orquestación con Kubernetes, observabilidad y seguridad integrada (DevSecOps).

## 2. Introducción
El proyecto busca modernizar el despliegue de una aplicación Spring Boot monolítica, aplicando prácticas DevOps para garantizar despliegues frecuentes, confiables y seguros. Se establecen métricas DORA para medir la madurez del equipo.

## 3. Arquitectura propuesta
La arquitectura incluye un pipeline en GitHub Actions que compila el código, ejecuta análisis de seguridad y construye una imagen Docker (publicada en GHCR). Posteriormente, la imagen es desplegada en un cluster Minikube local, el cual cuenta con entornos separados (`staging` y `prod`), y está monitorizado por el stack Prometheus/Grafana.

## 4. Pipeline CI/CD
El pipeline se divide en dos workflows:
- **CI (`ci.yml`)**: Valida código (JaCoCo >=80%), ejecuta SAST/SCA (Trivy, Gitleaks, SonarCloud) y publica la imagen a GHCR.
- **CD (`cd.yml`)**: Despliega automáticamente en `staging`. Tras superar el smoke test y aprobarse manualmente, despliega en `prod`. Emplea un self-hosted runner.

## 5. Infraestructura como código (IaC)
Se utilizó Terraform para aprovisionar el estado inicial en Minikube (usando el provider `kubernetes` y `helm`). Se aprovisionaron:
1. Namespace `staging`
2. Namespace `prod`
3. Stack de Monitoreo (kube-prometheus-stack).
En un entorno productivo, se conectaría con un Cloud Provider real (AWS/GCP/Azure) con backend remoto.

## 6. Kubernetes y estrategia de despliegue
Los despliegues en Kubernetes emplean la estrategia **RollingUpdate** para lograr zero-downtime. Se configuraron:
- **Probes**: `readinessProbe` y `livenessProbe` mediante los endpoints de Spring Boot Actuator.
- **Resources**: CPU (250m a 500m) y Memoria (512Mi a 768Mi).
- **HPA**: Autoescalado horizontal entre 2 y 10 réplicas al superar el 60% de CPU.
- **PDB**: Pod Disruption Budget para garantizar al menos 1 pod disponible en todo momento.

## 7. Observabilidad y SLO
Prometheus extrae métricas de Spring Boot a través de un `ServiceMonitor`. 
Grafana visualiza el cumplimiento de SLO mediante un dashboard con:
1. Request Rate (RPS).
2. Error Rate (5xx).
3. Latencia P99.
4. Conteo de Pods por Namespace.
El SLI objetivo es una disponibilidad del 99.9%.

## 8. DevSecOps
La seguridad (shift-left) está integrada en el pipeline:
- Escaneo de secretos: **Gitleaks**.
- Análisis de vulnerabilidades FS y Docker Image: **Trivy**.
- Análisis dinámico (DAST) contra `staging`: **OWASP ZAP**.
- Credenciales seguras: **Kubernetes Secrets**.

## 9. Métricas DORA
(Detalle extraído de `dora-metrics.md` en el repositorio)
- **Deployment Frequency**: Alta (On-demand tras merge).
- **Lead Time for Changes**: < 15 minutos.
- **Change Failure Rate**: Medible según incidentes registrados.
- **MTTR**: < 10 minutos (Verificado en simulación).

## 10. Incidente y post-mortem
Se provocó intencionalmente un error continuo (HTTP 500) atacando el endpoint `/oups` (CrashController). La anomalía se reflejó de inmediato en el dashboard de Grafana. Se mitigó el impacto mediante un `kubectl rollout undo`, restaurando el servicio. El análisis blameless se registró en `postmortem.md`.

## 11. Conclusiones y mejoras futuras
La arquitectura DevOps actual resulta sólida para validación local. Como próximos pasos:
- Migrar el Terraform a un cloud provider como AWS (EKS, RDS, ECR).
- Implementar GitOps con ArgoCD o Flux en lugar de `kubectl apply` manual desde GH Actions.
- Integrar Vault para gestión dinámica de Secrets.

## 12. Referencias
- Documentación oficial de Kubernetes, Spring Boot y GitHub Actions.
- Prácticas de Site Reliability Engineering (SRE) de Google.
- Aceleración DevOps - Métricas DORA.
