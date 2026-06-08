\# Métricas DORA



\## Deployment Frequency

\- Deploys realizados: 2 despliegues principales, staging y producción.

\- Periodo medido: Día 5 al Día 6 del taller.

\- Resultado: Bajo demanda durante el laboratorio.

\- Interpretación: El equipo puede desplegar automáticamente a staging y con aprobación a producción.



\## Lead Time for Changes

\- Commit analizado: último commit mergeado a develop.

\- Hora del commit: completar con hora de GitHub.

\- Hora del deploy exitoso a staging: completar con hora del workflow CD.

\- Resultado: aproximadamente entre 5 y 15 minutos.

\- Interpretación: El pipeline reduce el tiempo entre cambio y despliegue.



\## Change Failure Rate

\- Deploys totales: 2.

\- Deploys con incidente/rollback: 1 incidente simulado.

\- Fórmula: fallos / deploys totales \* 100.

\- Resultado: 1 / 2 \* 100 = 50% en laboratorio.

\- Interpretación: El valor es alto porque el incidente fue provocado intencionalmente para demostrar rollback.



\## MTTR

\- Inicio del incidente: completar con hora de inicio de error-gen.

\- Hora de detección: completar con hora donde Grafana muestra 5xx.

\- Hora de recuperación: completar con hora del rollback exitoso.

\- Resultado: aproximadamente 5 a 10 minutos.

\- Interpretación: La observabilidad permitió detectar y recuperar el servicio rápidamente.

