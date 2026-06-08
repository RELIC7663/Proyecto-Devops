\# Proyecto DevOps - Spring Petclinic



\## Arquitectura

Aplicación Spring Boot desplegada mediante pipeline CI/CD. La solución utiliza GitHub Actions, Docker, GHCR, Kubernetes en minikube, Prometheus, Grafana y prácticas DevSecOps.



\## Tecnologías

\- Java 17

\- Spring Boot

\- Maven

\- Docker

\- GHCR

\- Kubernetes / minikube

\- GitHub Actions

\- Prometheus

\- Grafana

\- Trivy

\- Gitleaks

\- SonarCloud



\## Ejecución local

```bash

cd app

mvn clean verify

mvn spring-boot:run

