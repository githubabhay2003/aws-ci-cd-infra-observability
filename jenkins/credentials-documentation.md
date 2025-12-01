# Jenkins Credentials (Non-sensitive Documentation)

This file documents only the IDs and purpose of Jenkins credentials.
Actual secret values are stored securely in Jenkins and are NOT committed here.

## Credentials

### 1. aws-devops-ci
- **Kind:** Username with password
- **Scope:** Global
- **Usage:** AWS access for Terraform/deployments run from Jenkins
- **Notes:** Username = AWS Access Key ID, Password = AWS Secret Access Key

### 2. github-pat-ci
- **Kind:** Secret text
- **Scope:** Global
- **Usage:** GitHub PAT for Jenkins (SCM checkout, GitHub integration)

### 3. github-webhook-secret
- **Kind:** Secret text
- **Scope:** Global
- **Usage:** Shared secret for GitHub → Jenkins webhooks

