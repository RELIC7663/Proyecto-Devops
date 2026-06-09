# Guion de Demo (10 minutos)
**Proyecto Integrador DevOps - Spring PetClinic**

## Minuto 0-1: Explicar Arquitectura
* **Visual**: Mostrar el diagrama de arquitectura del `README.md`.
* **Narrativa**: "Bienvenidos. Este es mi proyecto final DevOps. Tomamos la aplicación Spring PetClinic y le aplicamos un ciclo de vida moderno. Como ven en la arquitectura, el código va de GitHub a un runner de Actions, se compila y testea, la imagen sube a GHCR y de allí se despliega a un clúster Minikube local en los namespaces Staging y Prod."

## Minuto 1-2: Mostrar Repo y README
* **Visual**: Navegar por el repositorio de GitHub.
* **Narrativa**: "Aquí tenemos el código. La estructura está modularizada: el código en `app/`, CI/CD en `.github/`, Kubernetes en `k8s/`, y la infraestructura base con Terraform en la carpeta `terraform/`. El README contiene badges del estado y pasos para ejecutar."

## Minuto 2-4: Mostrar CI/CD Verde
* **Visual**: Pestaña de Actions en GitHub, mostrando una corrida exitosa de CI.
* **Narrativa**: "Vamos al pipeline de CI. Este se dispara en cada push. Vemos que compila, corre tests y valida cobertura con JaCoCo (mínimo 80%). También están los escaneos de seguridad: Gitleaks para secretos y Trivy para vulnerabilidades del sistema de archivos."

## Minuto 4-5: Mostrar Imagen GHCR
* **Visual**: Pestaña de Packages en el repositorio, mostrando la imagen Docker.
* **Narrativa**: "El job de Docker construye una imagen optimizada multi-stage, le pasa Trivy encima, y finalmente la publica en GitHub Container Registry. Aquí podemos ver el tag asociado al SHA del commit y a `latest`."

## Minuto 5-6: Mostrar Kubernetes (Pods/HPA)
* **Visual**: Terminal ejecutando comandos en Minikube o Lens/K9s.
* **Narrativa**: "Nuestro workflow de CD (CD.yml) despliega esto automáticamente en staging y con aprobación manual en producción. Si revisamos el clúster (`kubectl get pods,hpa -n staging`), tenemos pods corriendo con Probes configuradas, limitación de recursos y un HPA listo para escalar si el CPU supera el 60%."

## Minuto 6-8: Mostrar Grafana
* **Visual**: Dashboard de Grafana en el navegador.
* **Narrativa**: "Terraform nos levantó el namespace de `monitoring` con kube-prometheus-stack. A través de un ServiceMonitor recolectamos las métricas de Actuator de nuestra app. Este es nuestro Dashboard SLO. Aquí medimos el Request Rate, el Error Rate, la latencia P99 y la cantidad de pods levantados en cada ambiente."

## Minuto 8-9: Explicar Incidente y Rollback
* **Visual**: Dashboard mostrando un pico de 5xx y/o Post-mortem documentado.
* **Narrativa**: "Para validar la observabilidad, ejecutamos un test de estrés contra el endpoint que genera excepciones (`/oups`). Vimos cómo el panel de errores 5xx subió dramáticamente. La alerta habría sonado. Usamos `kubectl rollout undo` para revertir a una versión estable en segundos. Todo el evento quedó registrado en nuestro Post-Mortem bajo el enfoque blameless."

## Minuto 9-10: Explicar DORA y Cierre
* **Visual**: Archivo `dora-metrics.md`.
* **Narrativa**: "Finalmente, analizamos nuestro rendimiento usando las Métricas DORA. La frecuencia de despliegue aumentó, nuestro Lead Time cayó a 15 minutos, y gracias al pipeline y rollback, el MTTR en incidentes graves es menor a 10 minutos. Con esto cerramos el ciclo y logramos despliegues predecibles y seguros. ¡Gracias!"
