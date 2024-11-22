### Azure Terraform Configuration

This directory contains the Terraform configuration files for deploying resources on Microsoft Azure. Below are the details on how to set up and use the provided Terraform files.

#### Prérequis

Avant de commencer, assurez-vous d'avoir :

1. Un compte Azure actif.
2. Terraform installé sur votre machine.
3. Les permissions nécessaires pour créer des ressources sur Azure.

#### Configuration

Le fichier `main.tf` contient la configuration principale pour déployer des ressources sur Azure, telles que des machines virtuelles et des comptes de stockage. Vous pouvez personnaliser les ressources en modifiant les variables définies dans `variables.tf`.

#### Exemples d'utilisation

Pour déployer les ressources, exécutez les commandes suivantes dans le répertoire de ce projet :

1. `terraform init` - Pour initialiser le répertoire Terraform.
2. `terraform plan` - Pour voir le plan d'exécution.
3. `terraform apply` - Pour appliquer la configuration et créer les ressources.

#### Notes

Assurez-vous de consulter les fichiers `variables.tf` pour comprendre les variables que vous pouvez personnaliser pour votre déploiement.