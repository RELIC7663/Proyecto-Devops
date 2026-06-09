# Observability

This folder contains the Prometheus and Grafana assets required by the workshop:

- `prometheus.yml` scrapes Spring Boot Actuator Prometheus metrics.
- `alert-rules.yml` defines availability, 5xx and p99 latency alerts.
- `servicemonitor.yaml` supports Prometheus Operator in Kubernetes.
- `grafana/dashboards/petclinic-slo-dashboard.json` provides the SLO dashboard.

## Local run

Start the app first:

```bash
cd app
mvn spring-boot:run
```

Then start the monitoring stack from this folder:

```bash
docker compose up -d
```

Grafana: http://localhost:3000

Prometheus: http://localhost:9090
