### GCP Terraform Configuration

This directory contains the Terraform configuration files for deploying resources on Google Cloud Platform (GCP). Below are the details on how to set up and use the provided Terraform files.

#### Prérequis

Avant de commencer, assurez-vous d'avoir :

1. Un compte GCP actif.
2. Terraform installé sur votre machine.
3. Les permissions nécessaires pour créer des ressources sur GCP.

#### Configuration

1. **main.tf**: Ce fichier contient la configuration principale pour déployer des ressources sur GCP, telles que des instances Compute Engine et des buckets Cloud Storage.
2. **variables.tf**: Ce fichier définit les variables utilisées dans la configuration GCP, permettant de personnaliser les ressources créées.

#### Instructions d'utilisation

1. Clonez ce dépôt sur votre machine locale.
2. Naviguez vers le dossier `gcp`.
3. Modifiez le fichier `variables.tf` pour définir vos variables personnalisées.
4. Exécutez les commandes Terraform suivantes :
   - `terraform init` pour initialiser le répertoire.
   - `terraform plan` pour voir les ressources qui seront créées.
   - `terraform apply` pour appliquer la configuration et créer les ressources.

#### Exemples

Incluez ici des exemples d'utilisation spécifiques à votre configuration GCP.