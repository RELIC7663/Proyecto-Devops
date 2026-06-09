# Metricas DORA

Periodo medido: 2026-06-02 a 2026-06-08.

Estos valores corresponden al laboratorio y deben adjuntarse con capturas de GitHub Actions, despliegues y rollback.

## Deployment Frequency

- Deploys realizados: 2 despliegues principales, staging y produccion.
- Resultado: 2 despliegues por semana durante el laboratorio.
- Interpretacion: el equipo puede desplegar automaticamente a staging y promover a produccion con aprobacion.

## Lead Time for Changes

- Evento de referencia: commit mergeado a `develop`.
- Inicio: commit en GitHub.
- Fin: rollout exitoso en staging.
- Resultado estimado del laboratorio: 5 a 15 minutos.
- Interpretacion: el pipeline reduce el tiempo entre cambio y despliegue validado.

## Change Failure Rate

- Deploys totales: 2.
- Deploys con incidente o rollback: 1 incidente simulado.
- Formula: fallos / deploys totales * 100.
- Resultado: 1 / 2 * 100 = 50%.
- Interpretacion: el valor es alto porque el incidente fue provocado intencionalmente para demostrar deteccion y recuperacion.

## MTTR

- Inicio del incidente: 2026-06-08 09:10.
- Deteccion en Grafana: 2026-06-08 09:13.
- Rollback exitoso: 2026-06-08 09:18.
- Resultado: 8 minutos.
- Interpretacion: observabilidad y rollback permitieron recuperar el servicio dentro de la ventana esperada del taller.

## Comparacion con benchmark

- El flujo ya automatiza build, pruebas, seguridad, despliegue y observabilidad.
- Para mejorar el desempeno DORA, el siguiente paso es reducir fallos con tests de despliegue, alertas mas tempranas y automatizacion de rollback.
