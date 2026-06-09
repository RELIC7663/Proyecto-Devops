# Secrets Management

The repository must not store production credentials in plain text.

## Kubernetes Secrets

For the lab, the deployment references a Kubernetes Secret named `spring-petclinic-secret`.
Create or update it with real values outside Git:

```bash
kubectl create secret generic spring-petclinic-secret \
  --namespace staging \
  --from-literal=SPRING_DATASOURCE_USERNAME=petclinic \
  --from-literal=SPRING_DATASOURCE_PASSWORD='<replace-me>' \
  --dry-run=client -o yaml | kubectl apply -f -
```

Repeat for `prod` with production values.

## Terraform outputs

The Terraform RDS password is generated as a sensitive output:

```bash
terraform output -raw db_password
```

Store that value in Kubernetes Secrets, Vault, GitHub Actions secrets or another approved secret manager. Do not commit it.

## GitHub Actions secrets

Required repository secrets:

- `SONAR_TOKEN`: SonarCloud analysis token.
- Environment approval rules for `prod`: configured in GitHub Environments.
- GHCR push uses `GITHUB_TOKEN`, provided automatically by GitHub Actions.
