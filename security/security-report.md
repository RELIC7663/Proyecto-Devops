# Security Report

## Controls implemented

| Control | Tool | Location | Status |
|---|---|---|---|
| Secret scanning | Gitleaks | `.github/workflows/ci.yml`, `.pre-commit-config.yaml` | Implemented |
| SAST / quality gate | SonarCloud | `.github/workflows/ci.yml` | Implemented |
| SCA and image vulnerability scan | Trivy | `.github/workflows/ci.yml` | Implemented |
| DAST baseline | OWASP ZAP | `.github/workflows/ci.yml` | Implemented |
| Container hardening | Non-root Docker image | `app/Dockerfile` | Implemented |
| Kubernetes hardening | Probes, resource limits, security context | `k8s/deployment.yaml` | Implemented |
| Secret handling | Kubernetes Secrets and GitHub Secrets | `k8s/secret.yaml`, `security/secrets-management.md` | Implemented |

## Risk decisions

- Trivy fails the pipeline on critical vulnerabilities to support the "zero critical CVEs" objective.
- ZAP baseline is configured as evidence and triage, not as a blocking gate, because baseline scans may report context-dependent warnings that require manual review.
- SonarCloud is set as non-blocking in this lab pipeline so the workflow can run even before `SONAR_TOKEN` is configured. In a production repository, remove `continue-on-error: true`.

## Manual evidence to attach

- Screenshot of a successful GitHub Actions CI run.
- Screenshot or artifact of Trivy scan output with zero critical CVEs.
- SonarCloud project summary.
- ZAP baseline artifact.
- Kubernetes rollout status for staging and production.
