
# Akeyless K8s Secrets Injector

## Overview

The Akeyless K8s Secrets Injector plugin enables K8s applications and workloads to use Static, Rotated, and Dynamic secrets as well as Certificates sourced from the Akeyless Platform.

This injector leverages the K8s MutatingAdmissionWebhook to intercept and augment specifically annotated pod configurations for secrets injection. By doing so, the user benefits as the applications remain ״Akeyless unaware״ as the secrets are stored either as an environment variable or as a file at a filesystem path in their container.

![k8s flow](https://files.readme.io/fcf538d-k8s-injection.png)


## Implementation  
Execution steps and commands:

### Create an Access Role

```bash
akeyless create-role --name /K8s/K8s_Role
akeyless assoc-role-am --role-name /K8s/K8s_Role --am-name K8s/K8s_Auth
akeyless set-role-rule --role-name /K8s/K8s_Role --path /K8s/'*' --capability read --capability list

```