### **Quiz : Terraform**  

#### **Instructions :**  
Répondez à chaque question en choisissant la meilleure réponse. Chaque question vaut 1 point. Bonne chance !

---

### **1. Quelle est la principale fonction de Terraform ?**  
- A. Automatiser la configuration des serveurs.  
- B. Gérer l’infrastructure en tant que code (IaC).  
- C. Monitorer les applications et services.  
- D. Déployer uniquement des conteneurs Docker.  

---

### **2. Quelle commande Terraform permet d’initialiser un répertoire de travail ?**  
- A. `terraform start`  
- B. `terraform init`  
- C. `terraform setup`  
- D. `terraform initialize`  

---

### **3. Quel est le format par défaut des fichiers de configuration Terraform ?**  
- A. YAML  
- B. JSON  
- C. HCL  
- D. XML  

---

### **4. Comment se nomme le fichier principal de configuration Terraform ?**  
- A. `terraform.yaml`  
- B. `main.hcl`  
- C. `main.tf`  
- D. `config.json`  

---

### **5. Quelle commande Terraform est utilisée pour créer ou mettre à jour l’infrastructure définie dans le fichier de configuration ?**  
- A. `terraform plan`  
- B. `terraform create`  
- C. `terraform apply`  
- D. `terraform deploy`  

---

### **6. Quelle commande Terraform affiche un aperçu des modifications qui seront effectuées sur l'infrastructure ?**  
- A. `terraform show`  
- B. `terraform dry-run`  
- C. `terraform plan`  
- D. `terraform preview`  

---

### **7. Que signifie "State" dans Terraform ?**  
- A. Les fichiers de configuration utilisés par Terraform.  
- B. Une base de données pour gérer l'infrastructure.  
- C. Un fichier qui suit l'état actuel des ressources gérées par Terraform.  
- D. Une ressource temporaire créée par Terraform.  

---

### **8. Où se trouve le fichier d’état (`terraform.tfstate`) par défaut ?**  
- A. Dans un bucket S3.  
- B. Dans le répertoire courant.  
- C. Sur un serveur distant.  
- D. Dans un fichier chiffré local.  

---

### **9. Quelle est la meilleure pratique pour partager l'état Terraform entre plusieurs utilisateurs ?**  
- A. Le sauvegarder dans un bucket S3 avec un verrouillage DynamoDB.  
- B. Utiliser un disque partagé sur le réseau local.  
- C. Envoyer manuellement le fichier `.tfstate` aux autres utilisateurs.  
- D. Toujours travailler seul pour éviter les conflits.  

---

### **10. Quelle commande Terraform est utilisée pour détruire l’infrastructure gérée ?**  
- A. `terraform delete`  
- B. `terraform destroy`  
- C. `terraform teardown`  
- D. `terraform remove`  

---

### **11. Quel fournisseur (provider) Terraform permet de gérer les ressources AWS ?**  
- A. `terraform_aws`  
- B. `provider_aws`  
- C. `aws`  
- D. `aws_terraform`  

---

### **12. Quelle section est utilisée pour spécifier les informations d’un fournisseur dans un fichier Terraform ?**  
- A. `resource`  
- B. `provider`  
- C. `module`  
- D. `variable`  

---

### **13. Quelle est la fonction principale des variables dans Terraform ?**  
- A. Fournir des entrées dynamiques aux fichiers de configuration.  
- B. Gérer les dépendances entre ressources.  
- C. Définir les versions des modules.  
- D. Documenter le fichier de configuration.  

---

### **14. Comment Terraform gère-t-il les dépendances entre ressources ?**  
- A. À l’aide de la commande `terraform dependency`.  
- B. En analysant automatiquement les références entre ressources.  
- C. En définissant explicitement chaque dépendance dans un fichier dédié.  
- D. À l’aide d’une base de données externe.  

---

### **15. Quelle est la meilleure pratique pour sécuriser les informations sensibles dans Terraform (par exemple, clés API) ?**  
- A. Les inclure dans les fichiers `.tf` directement.  
- B. Utiliser des variables d'environnement.  
- C. Les stocker dans des fichiers `.json`.  
- D. Les ajouter au fichier `terraform.tfstate`.  

---

### **16. Quel type de ressource est créé avec cette configuration Terraform ?**
```hcl
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name"
  acl    = "private"
}
```  
- A. Un serveur web EC2.  
- B. Un groupe de sécurité.  
- C. Un bucket S3.  
- D. Une table DynamoDB.  

---

### **17. Quelle commande Terraform permet de vérifier si une configuration est valide ?**  
- A. `terraform plan`  
- B. `terraform validate`  
- C. `terraform lint`  
- D. `terraform check`  

---

### **18. Que fait la commande `terraform refresh` ?**  
- A. Recharge le fichier de configuration.  
- B. Met à jour l’état Terraform en fonction des ressources actuelles.  
- C. Réinitialise le fournisseur Terraform.  
- D. Supprime l’état Terraform.  

---

### **19. Quelle est la différence entre un module et une ressource dans Terraform ?**  
- A. Un module est une collection de ressources configurées pour une tâche spécifique.  
- B. Une ressource est utilisée pour gérer plusieurs modules.  
- C. Un module est un fournisseur de ressources.  
- D. Une ressource est utilisée pour définir les variables Terraform.  

---

### **20. Quelle commande Terraform permet de verrouiller une version spécifique d’un fournisseur ?**  
- A. `provider_version`  
- B. `terraform lock-provider`  
- C. Spécifier la version dans le bloc `provider`.  
- D. Ajouter la commande `--lock-version`.  

---

### **21. Que signifie "immutable infrastructure" dans le contexte de Terraform ?**  
- A. L'infrastructure est modifiée directement sans recréation des ressources.  
- B. Les modifications de l'infrastructure nécessitent de recréer toutes les ressources.  
- C. L'infrastructure ne peut pas être modifiée.  
- D. L’infrastructure est gérée par plusieurs états.  

---

### **22. Que permet la fonction `terraform output` ?**  
- A. Exporter des informations sur l'infrastructure créée.  
- B. Générer un fichier de sauvegarde.  
- C. Lister les erreurs de configuration.  
- D. Écrire les résultats dans un fichier JSON.  

---

### **23. Que signifie "drift" dans le contexte de Terraform ?**  
- A. Une différence entre la configuration et l'état réel des ressources.  
- B. Une modification dans le fichier `.tfstate`.  
- C. Une défaillance dans l’application des ressources.  
- D. Une erreur dans le fichier de configuration.  

---

### **24. Quelle commande Terraform peut être utilisée pour importer une ressource existante dans l’état Terraform ?**  
- A. `terraform pull`  
- B. `terraform import`  
- C. `terraform state-add`  
- D. `terraform sync`  

---

### **25. Quel est le rôle de la section `backend` dans un fichier Terraform ?**  
- A. Configurer la gestion des variables d'environnement.  
- B. Définir où et comment stocker l'état Terraform.  
- C. Activer les modules distants.  
- D. Configurer le fournisseur Terraform.  

---

### **26. Quelle commande permet de récupérer les modules distants ?**  
- A. `terraform fetch`  
- B. `terraform init`  
- C. `terraform modules`  
- D. `terraform get`  

---

### **27. Quelle option est utilisée pour exécuter `terraform apply` sans demander confirmation ?**  
- A. `--yes`  
- B. `--auto-approve`  
- C. `--force`  
- D. `--no-confirm`  

---

### **28. Que se passe-t-il si un fichier `.tf` contient une syntaxe incorrecte ?**  
- A. Terraform ignore les erreurs et applique le fichier.  
- B. Terraform génère un avertissement mais continue.  
- C. Terraform renvoie une erreur lors de l’exécution de `terraform validate`.  
- D. Terraform corrige automatiquement la syntaxe.  

---

### **29. Quel est l'objectif principal d’un bloc `data` dans Terraform ?**  
- A. Créer une nouvelle ressource.  
- B. Récupérer des informations sur des ressources existantes.  
- C. Stocker des informations sensibles.  
- D. Configurer des variables.  

---

### **30. Quelle est la commande pour afficher l’état Terraform sous forme lisible ?**  
- A. `terraform show`  
- B. `terraform describe`  
- C. `terraform display`  
- D. `terraform status`  

