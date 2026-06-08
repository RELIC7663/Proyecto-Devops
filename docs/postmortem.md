\# Post-mortem blameless



\## Resumen

Se simuló un incidente generando respuestas HTTP 500 sobre la aplicación Spring Petclinic en el entorno staging. El objetivo fue validar observabilidad, detección en Grafana y recuperación mediante rollback.



\## Impacto

\- Entorno afectado: staging.

\- Servicio afectado: spring-petclinic.

\- Síntoma visible: aumento del Error Rate 5xx en Grafana.

\- Usuarios afectados: no hubo usuarios reales; fue un incidente controlado de laboratorio.



\## Timeline

| Hora | Evento |

|---|---|

| HH:MM | Inicio de generación de tráfico normal |

| HH:MM | Inicio del incidente con requests a /oups |

| HH:MM | Grafana refleja aumento de errores 5xx |

| HH:MM | Se ejecuta rollback del deployment |

| HH:MM | Servicio vuelve a estado estable |



\## Root cause

Se generó tráfico hacia un endpoint diseñado para provocar error HTTP 500. El incidente fue intencional y controlado para validar el proceso de detección y recuperación.



\## 5 Whys

1\. ¿Por qué subió el error rate? Porque se enviaron requests a un endpoint que devuelve error.

2\. ¿Por qué se detectó? Porque Prometheus recolectó métricas HTTP y Grafana las visualizó.

3\. ¿Por qué se pudo recuperar? Porque Kubernetes mantiene historial de ReplicaSets y permite rollback.

4\. ¿Por qué no afectó producción? Porque se ejecutó en staging.

5\. ¿Por qué fue útil? Porque validó observabilidad, alertamiento y recuperación.



\## Qué funcionó bien

\- Prometheus recolectó métricas de la aplicación.

\- Grafana mostró request rate, error rate, P99 y cantidad de pods.

\- Kubernetes permitió rollback.

\- El proceso fue blameless y orientado al aprendizaje.



\## Qué no funcionó bien

\- El error fue simulado manualmente.

\- Se requiere automatizar alertas y runbooks.

\- El manejo de Secrets debe mejorar para producción.



\## Action items

| Acción | Responsable | Fecha límite | Estado |

|---|---|---|---|

| Automatizar alerta por 5xx > 1% | Equipo DevOps | Fin del sprint | Pendiente |

| Documentar runbook de rollback | Equipo DevOps | Fin del sprint | En proceso |

| Revisar gestión de Secrets con Vault o Sealed Secrets | Equipo DevSecOps | Próximo sprint | Pendiente |

| Agregar evidencia DORA al informe final | Equipo | Entrega final | En proceso |

