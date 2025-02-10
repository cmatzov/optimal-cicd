# CI/CD Pipeline for Optimal Projects

This repository contains a CI/CD pipeline configuration for managing and automating the build, test, and deployment processes for multiple projects, including `ikea`, `verila`, and `kti`. The configuration leverages reusable templates and job definitions to streamline the pipeline.

---

## Overview

The pipeline is divided into multiple stages:

1. **Backup**: Create daily backups for critical environments.
2. **Restore**: Clear test environments and restore databases.
3. **Analyze**: Perform backend and frontend static code analysis.
4. **Tag**: Generate version tags and determine deployment environments.
5. **Build**: Build Docker images for each project.
6. **Select Test Machine**: Assign test machines for deployment testing.
7. **Deploy**: Deploy services to the appropriate environments.
8. **Clear**: Clear old test environments.
9. **Rollback**: Roll back to previous versions in case of failure.

---

## Key Features

### Dynamic Job Templates
The pipeline extends reusable job templates from included helper configurations:

- **ci-helpers.yml**: Contains definitions for common CI tasks like backups and analysis.
- **cd-helpers.yml**: Manages deployment logic.
- **automation-helpers.yml**: Automates additional tasks, such as tagging and artifact handling.

### Rules and Variables
- Conditional execution ensures jobs run only for specific triggers (e.g., scheduled pipelines, branch-based triggers).
- Environment variables dynamically adjust behavior for `test`, `stage`, and `production` environments.

### Artifact Management
- Static analysis artifacts (e.g., `roslynator.txt`, `inspectcode.xml`) are stored for debugging and expire after one day.

### Security
- Secrets for environments (e.g., admin credentials) are currently plaintext but should be replaced with securely managed CI/CD variables.

---

## Stage Details

### Backup
Daily backups are created using the `.ikea-daily-backups` job template. This stage is triggered based on the pipeline's schedule.

### Restore
The `.clear-test-and-db-restore` job restores test databases and clears old environments, ensuring clean test setups.

### Analyze
- **Backend Analysis**: Uses Roslynator and JetBrains InspectCode to analyze `.NET` code.
- **Frontend Analysis**: Lints JavaScript code using `npm` and `expo-cli`.

### Tag
Generates version tags based on branch names:
- `master`: Production tags.
- `develop` and `release`: Stage tags.
- `hotfix`: Incremental patch tags.

### Build
Builds Docker images for all projects with environment-specific configurations.

### Deploy
Deploys images to the appropriate environments after building.

### Rollback
Automates rollback to previous versions in case of deployment failures.

---

## How to Trigger

### Scheduled Pipelines
- Jobs like `Daily Backups`, `Restore Database`, and `Rollback` are triggered automatically based on schedules defined in the pipeline.

### Manual Pipelines
- Specific jobs can be triggered manually for testing or on-demand deployments.

---

## Improvements

### Security
- Replace plaintext secrets with secure CI/CD variables or secret management systems.

### Caching
- Add `cache` directives to optimize dependency installation for faster builds.

### Modularization
- Move inline scripts to external files for better readability and maintainability.

### Testing
- Add explicit stages for backend and frontend unit tests to improve quality assurance.

---

## Contributing

1. Fork the repository.
2. Create a new branch for your feature or fix.
3. Commit your changes with descriptive messages.
4. Submit a pull request and await review.

---

## License
This project is licensed under [MIT License](LICENSE).

---

## Acknowledgments
Special thanks to the DevOps team for their contributions to the pipeline design and optimization.# CI/CD Pipeline for Optimal Projects

This repository contains a CI/CD pipeline configuration for managing and automating the build, test, and deployment processes for multiple projects, including `ikea`, `verila`, and `kti`. The configuration leverages reusable templates and job definitions to streamline the pipeline.

---

## Overview

The pipeline is divided into multiple stages:

1. **Backup**: Create daily backups for critical environments.
2. **Restore**: Clear test environments and restore databases.
3. **Analyze**: Perform backend and frontend static code analysis.
4. **Tag**: Generate version tags and determine deployment environments.
5. **Build**: Build Docker images for each project.
6. **Select Test Machine**: Assign test machines for deployment testing.
7. **Deploy**: Deploy services to the appropriate environments.
8. **Clear**: Clear old test environments.
9. **Rollback**: Roll back to previous versions in case of failure.

---

## Key Features

### Dynamic Job Templates
The pipeline extends reusable job templates from included helper configurations:

- **ci-helpers.yml**: Contains definitions for common CI tasks like backups and analysis.
- **cd-helpers.yml**: Manages deployment logic.
- **automation-helpers.yml**: Automates additional tasks, such as tagging and artifact handling.

### Rules and Variables
- Conditional execution ensures jobs run only for specific triggers (e.g., scheduled pipelines, branch-based triggers).
- Environment variables dynamically adjust behavior for `test`, `stage`, and `production` environments.

### Artifact Management
- Static analysis artifacts (e.g., `roslynator.txt`, `inspectcode.xml`) are stored for debugging and expire after one day.

### Security
- Secrets for environments (e.g., admin credentials) are currently plaintext but should be replaced with securely managed CI/CD variables.

---

## Stage Details

### Backup
Daily backups are created using the `.ikea-daily-backups` job template. This stage is triggered based on the pipeline's schedule.

### Restore
The `.clear-test-and-db-restore` job restores test databases and clears old environments, ensuring clean test setups.

### Analyze
- **Backend Analysis**: Uses Roslynator and JetBrains InspectCode to analyze `.NET` code.
- **Frontend Analysis**: Lints JavaScript code using `npm` and `expo-cli`.

### Tag
Generates version tags based on branch names:
- `master`: Production tags.
- `develop` and `release`: Stage tags.
- `hotfix`: Incremental patch tags.

### Build
Builds Docker images for all projects with environment-specific configurations.

### Deploy
Deploys images to the appropriate environments after building.

### Rollback
Automates rollback to previous versions in case of deployment failures.

---

## How to Trigger

### Scheduled Pipelines
- Jobs like `Daily Backups` and `Restore Database` are triggered automatically based on schedules defined in the pipeline.

### Manual Pipelines
- Specific jobs can be triggered manually for testing or on-demand deployments.

---

## Acknowledgments
Special thanks to the DevOps team for their contributions to the pipeline design and optimization even if no one is going to use them maika vi deba.