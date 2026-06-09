# DevSecOps

This folder documents the security controls used by the project.

## Local checks

```bash
pre-commit install
pre-commit run --all-files
```

## CI checks

The pipeline executes:

- Gitleaks for secret scanning.
- Maven tests and JaCoCo coverage gate.
- SonarCloud for SAST and quality analysis.
- Trivy for filesystem and container image vulnerability scanning.
- OWASP ZAP baseline against a locally started Petclinic instance.

See `security-report.md` for the evidence checklist.
