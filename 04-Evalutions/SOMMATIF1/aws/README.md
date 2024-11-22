# Guide AWS : Analyse et compréhension de la configuration Terraform pour AWS

---

**Introduction** :  
Dans cet exercice, vous êtes invités à **lire, commenter et analyser** les fichiers de configuration Terraform fournis pour Amazon Web Services (AWS). Votre objectif principal est de répondre aux questions à choix multiples et d'expliquer chaque composant des fichiers.

---

### Fichiers fournis à analyser

#### **1. `main.tf`**
- Ce fichier définit les ressources à créer sur AWS, comme des instances EC2 et des buckets S3.
- À vous d'identifier l'objectif de chaque section, de commenter et d'expliquer pourquoi ce fichier est essentiel dans une configuration Terraform.

#### **2. `variables.tf`**
- Contient les variables utilisées dans `main.tf`, comme la région AWS, le type d'instance, le nom du bucket S3, etc.
- Analysez la structure et expliquez l'intérêt d'utiliser des variables dans une configuration.

#### **3. Exemple de ressources**  
   - **Bucket S3 :**  
   ```hcl
   resource "aws_s3_bucket" "example" {
     bucket = var.s3_bucket_name
     acl    = "private"
   }
   ```
   - **Instance EC2 :**  
   ```hcl
   resource "aws_instance" "example" {
     ami           = var.ami_id
     instance_type = var.instance_type

     tags = {
       Name = "ExampleInstance"
     }
   }
   ```

#### **4. Provider**
   - Analysez la configuration du provider AWS :  
   ```hcl
   provider "aws" {
     region = var.aws_region
   }
   ```
   - Commentez l'importance de cette section dans une configuration Terraform pour AWS.

---

### Quiz à choix multiples (10 questions)

1. **Que contient le fichier `main.tf` et pourquoi est-il important ?**  
   a) Les paramètres de configuration globaux d'AWS.  
   b) Les ressources AWS à déployer.  
   c) Les logs de Terraform.  
   d) Le code CloudFormation.  

2. **Quelle est la fonction de `variables.tf` dans une configuration Terraform pour AWS ?**  
   a) Stocker les secrets AWS.  
   b) Définir des valeurs codées en dur pour toutes les ressources.  
   c) Centraliser les paramètres pour une meilleure réutilisabilité.  
   d) Gérer les politiques IAM.  

3. **Quel est le rôle de la ressource `aws_s3_bucket` ?**  
   a) Créer un bucket de stockage S3.  
   b) Définir les règles de pare-feu.  
   c) Configurer un VPC.  
   d) Gérer les utilisateurs IAM.  

4. **Pourquoi utilise-t-on des variables comme `var.aws_region` au lieu de valeurs codées en dur ?**  
   a) Pour accélérer le déploiement.  
   b) Pour simplifier la personnalisation et la maintenance.  
   c) Pour respecter les quotas AWS.  
   d) Pour crypter les données sensibles.  

5. **Que représente le bloc `tags` dans la ressource `aws_instance` ?**  
   a) Le réseau associé à l'instance.  
   b) Les métadonnées associées à l'instance EC2.  
   c) Les paramètres de sauvegarde.  
   d) La configuration du pare-feu de l'instance.  

6. **Quelle est l'importance du paramètre `acl` dans la configuration du bucket S3 ?**  
   a) Définir les permissions d'accès au bucket.  
   b) Configurer la réplication du bucket.  
   c) Spécifier le type de stockage.  
   d) Définir la politique de chiffrement.  

7. **Dans la ressource `aws_instance`, que signifie `ami` ?**  
   a) Amazon Machine Interface.  
   b) Amazon Managed Instance.  
   c) Amazon Machine Image.  
   d) Amazon Monitored Infrastructure.  

8. **Pourquoi la variable `key_name` est-elle importante pour une instance EC2 ?**  
   a) Pour définir le nom de l'instance.  
   b) Pour spécifier la paire de clés pour l'accès SSH.  
   c) Pour configurer le chiffrement des volumes EBS.  
   d) Pour nommer le groupe de sécurité associé.  

9. **Quelle est la signification de la valeur par défaut "t2.micro" pour la variable `instance_type` ?**  
   a) C'est le type d'instance le plus puissant.  
   b) C'est le type d'instance gratuit dans la free tier d'AWS.  
   c) C'est le seul type d'instance compatible avec Terraform.  
   d) C'est le type d'instance recommandé pour la production.  

10. **Quelle commande Terraform utiliseriez-vous pour appliquer cette configuration sur AWS ?**  
    a) `terraform run`  
    b) `terraform execute`  
    c) `terraform apply`  
    d) `terraform deploy`  

---

### Consignes

1. **Analysez chaque fichier** et écrivez vos commentaires en réponse à chaque composant.
2. **Répondez au quiz** en justifiant vos choix.
3. Soyez concis mais précis. Montrez une compréhension approfondie de chaque aspect de la configuration AWS avec Terraform.

Bonne chance ! 🎓
