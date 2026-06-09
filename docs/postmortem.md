# Post-mortem blameless

## Resumen

El 2026-06-08 se simulo un incidente en staging generando respuestas HTTP 500 sobre Spring Petclinic. El objetivo fue validar observabilidad, alertamiento, diagnostico y recuperacion mediante rollback.

## Impacto

- Entorno afectado: staging.
- Servicio afectado: spring-petclinic.
- Sintoma visible: aumento del error rate 5xx en Grafana.
- Usuarios afectados: no hubo usuarios reales; fue un incidente controlado de laboratorio.

## Timeline

| Hora | Evento |
|---|---|
| 09:00 | Despliegue exitoso de staging desde `develop`. |
| 09:05 | Inicio de trafico normal hacia `/`, `/owners` y `/vets.html`. |
| 09:10 | Inicio del incidente con solicitudes hacia `/oups`. |
| 09:13 | Grafana muestra aumento de errores 5xx y alerta de error rate. |
| 09:15 | Equipo identifica que el error proviene del endpoint de fallo controlado. |
| 09:17 | Se ejecuta rollback del deployment en Kubernetes. |
| 09:18 | Servicio vuelve a estado estable. |

## Root Cause

El incidente fue provocado por trafico hacia un endpoint disenado para responder con HTTP 500. No fue un defecto accidental de codigo productivo, sino una simulacion para validar el proceso operativo.

## 5 Whys

1. Por que subio el error rate? Porque se enviaron solicitudes a un endpoint que devuelve error.
2. Por que se detecto? Porque Prometheus recolecto metricas HTTP y Grafana mostro el aumento de 5xx.
3. Por que se pudo recuperar? Porque Kubernetes mantenia historial de ReplicaSets y permitio rollback.
4. Por que no afecto produccion? Porque se ejecuto solo en staging.
5. Por que fue util? Porque valido observabilidad, alertamiento y recuperacion del equipo.

## Que funciono bien

- Prometheus recolecto metricas de la aplicacion.
- Grafana mostro request rate, error rate, p99 y disponibilidad.
- Kubernetes permitio rollback rapido.
- El analisis fue blameless y orientado al aprendizaje.

## Que no funciono bien

- La alerta aun requiere evidencia manual en el informe.
- El incidente fue simulado manualmente.
- El manejo de secretos debe fortalecerse para produccion real.

## Action Items

| Accion | Responsable | Fecha limite | Estado |
|---|---|---|---|
| Adjuntar captura de alerta por 5xx > 1% | Equipo DevOps | Entrega final | Pendiente |
| Documentar runbook de rollback | Equipo DevOps | Entrega final | En proceso |
| Mover secretos reales a Vault, GitHub Secrets o Kubernetes Secrets creados fuera de Git | Equipo DevSecOps | Proximo sprint | Pendiente |
| Adjuntar evidencia DORA al informe final | Equipo | Entrega final | En proceso |
