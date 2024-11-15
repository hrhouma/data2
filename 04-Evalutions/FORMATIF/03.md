# Réponses :

### **1. Quelle est la principale fonction de Terraform ?**  
**Réponse : B. Gérer l’infrastructure en tant que code (IaC).**  
Terraform permet de gérer et provisionner des ressources cloud et on-premise via des fichiers de configuration déclaratifs. Cela permet une gestion cohérente et reproductible de l’infrastructure.

---

### **2. Quelle commande Terraform permet d’initialiser un répertoire de travail ?**  
**Réponse : B. `terraform init`.**  
Cette commande initialise le répertoire de travail en téléchargeant les plugins des fournisseurs nécessaires et en configurant le backend pour gérer l’état Terraform.

---

### **3. Quel est le format par défaut des fichiers de configuration Terraform ?**  
**Réponse : C. HCL.**  
Terraform utilise le **HashiCorp Configuration Language (HCL)**, un langage conçu pour être lisible par les humains et facilement analysable par les machines.

---

### **4. Comment se nomme le fichier principal de configuration Terraform ?**  
**Réponse : C. `main.tf`.**  
Par convention, le fichier principal contenant la configuration est souvent nommé `main.tf`, mais vous pouvez utiliser d'autres noms avec l'extension `.tf`.

---

### **5. Quelle commande Terraform est utilisée pour créer ou mettre à jour l’infrastructure définie dans le fichier de configuration ?**  
**Réponse : C. `terraform apply`.**  
Cette commande applique les modifications nécessaires pour que l’état réel de l’infrastructure corresponde à ce qui est défini dans les fichiers de configuration.

---

### **6. Quelle commande Terraform affiche un aperçu des modifications qui seront effectuées sur l'infrastructure ?**  
**Réponse : C. `terraform plan`.**  
Elle génère un plan d'exécution qui montre quelles actions Terraform effectuera sans réellement appliquer les modifications.

---

### **7. Que signifie "State" dans Terraform ?**  
**Réponse : C. Un fichier qui suit l'état actuel des ressources gérées par Terraform.**  
Le fichier d’état (`terraform.tfstate`) permet à Terraform de savoir quelles ressources existent déjà et quelles modifications sont nécessaires.

---

### **8. Où se trouve le fichier d’état (`terraform.tfstate`) par défaut ?**  
**Réponse : B. Dans le répertoire courant.**  
Par défaut, Terraform stocke l’état dans un fichier local appelé `terraform.tfstate`. Cependant, il peut être configuré pour utiliser un backend distant (comme S3).

---

### **9. Quelle est la meilleure pratique pour partager l'état Terraform entre plusieurs utilisateurs ?**  
**Réponse : A. Le sauvegarder dans un bucket S3 avec un verrouillage DynamoDB.**  
Cela garantit que l’état est centralisé, accessible par plusieurs utilisateurs et protégé contre les accès simultanés grâce au verrouillage DynamoDB.

---

### **10. Quelle commande Terraform est utilisée pour détruire l’infrastructure gérée ?**  
**Réponse : B. `terraform destroy`.**  
Cette commande supprime toutes les ressources définies dans l’état Terraform, ce qui peut être utile pour nettoyer une infrastructure.

---

### **11. Quel fournisseur (provider) Terraform permet de gérer les ressources AWS ?**  
**Réponse : C. `aws`.**  
Le bloc `provider "aws"` est utilisé pour configurer les informations nécessaires à la gestion des ressources AWS.

---

### **12. Quelle section est utilisée pour spécifier les informations d’un fournisseur dans un fichier Terraform ?**  
**Réponse : B. `provider`.**  
Le bloc `provider` est utilisé pour configurer les fournisseurs tels qu’AWS, Azure ou Google Cloud, en spécifiant les informations nécessaires comme les régions ou les identifiants.

---

### **13. Quelle est la fonction principale des variables dans Terraform ?**  
**Réponse : A. Fournir des entrées dynamiques aux fichiers de configuration.**  
Les variables rendent les configurations flexibles en permettant de passer des valeurs au moment de l’exécution.

---

### **14. Comment Terraform gère-t-il les dépendances entre ressources ?**  
**Réponse : B. En analysant automatiquement les références entre ressources.**  
Terraform détecte automatiquement les dépendances basées sur les références utilisées entre les ressources.

---

### **15. Quelle est la meilleure pratique pour sécuriser les informations sensibles dans Terraform (par exemple, clés API) ?**  
**Réponse : B. Utiliser des variables d'environnement.**  
Les informations sensibles ne doivent pas être incluses dans les fichiers `.tf` ou `.tfstate`. Les variables d'environnement sont une méthode sûre pour gérer ces données.

---

### **16. Quel type de ressource est créé avec cette configuration Terraform ?**  
**Réponse : C. Un bucket S3.**  
Le bloc `resource "aws_s3_bucket"` crée un bucket S3 avec des paramètres comme le nom et les autorisations.

---

### **17. Quelle commande Terraform permet de vérifier si une configuration est valide ?**  
**Réponse : B. `terraform validate`.**  
Cette commande vérifie la syntaxe et la validité des fichiers de configuration Terraform sans appliquer de modifications.

---

### **18. Que fait la commande `terraform refresh` ?**  
**Réponse : B. Met à jour l’état Terraform en fonction des ressources actuelles.**  
Elle synchronise l’état Terraform avec les ressources existantes pour refléter les modifications manuelles éventuelles.

---

### **19. Quelle est la différence entre un module et une ressource dans Terraform ?**  
**Réponse : A. Un module est une collection de ressources configurées pour une tâche spécifique.**  
Les modules sont des groupes réutilisables de ressources configurées pour simplifier la gestion de configurations complexes.

---

### **20. Quelle commande Terraform permet de verrouiller une version spécifique d’un fournisseur ?**  
**Réponse : C. Spécifier la version dans le bloc `provider`.**  
Dans le bloc `provider`, vous pouvez définir une version précise ou une plage de versions pour le fournisseur.

---

### **21. Que signifie "immutable infrastructure" dans le contexte de Terraform ?**  
**Réponse : B. Les modifications de l'infrastructure nécessitent de recréer toutes les ressources.**  
Terraform adopte souvent une approche immuable, où les modifications impliquent la destruction et la recréation des ressources pour garantir la cohérence.

---

### **22. Que permet la fonction `terraform output` ?**  
**Réponse : A. Exporter des informations sur l'infrastructure créée.**  
Cette commande affiche les sorties définies dans la section `output` du fichier de configuration, utiles pour partager des informations comme des adresses IP.

---

### **23. Que signifie "drift" dans le contexte de Terraform ?**  
**Réponse : A. Une différence entre la configuration et l'état réel des ressources.**  
Le drift se produit lorsque des modifications manuelles sont apportées directement aux ressources sans passer par Terraform.

---

### **24. Quelle commande Terraform peut être utilisée pour importer une ressource existante dans l’état Terraform ?**  
**Réponse : B. `terraform import`.**  
Elle permet d’associer une ressource existante à Terraform pour qu’elle soit gérée par son état.

---

### **25. Quel est le rôle de la section `backend` dans un fichier Terraform ?**  
**Réponse : B. Définir où et comment stocker l'état Terraform.**  
Le backend configure la gestion de l’état, localement ou sur des solutions distantes comme S3 ou Azure Blob Storage.

---

### **26. Quelle commande permet de récupérer les modules distants ?**  
**Réponse : D. `terraform get`.**  
Cette commande télécharge les modules spécifiés dans la configuration Terraform.

---

### **27. Quelle option est utilisée pour exécuter `terraform apply` sans demander confirmation ?**  
**Réponse : B. `--auto-approve`.**  
Cette option permet de bypasser la demande de confirmation et d'appliquer directement les modifications.

---

### **28. Que se passe-t-il si un fichier `.tf` contient une syntaxe incorrecte ?**  
**Réponse : C. Terraform renvoie une erreur lors de l’exécution de `terraform validate`.**  
Terraform ne permet pas l’exécution si des erreurs de syntaxe sont détectées.

---

### **29. Quel est l'objectif principal d’un bloc `data` dans Terraform ?**  
**Réponse : B. Récupérer des informations sur des ressources existantes.**  
Les blocs `data` sont utilisés pour lire des données externes ou des ressources existantes sans les gérer.

---

### **30. Quelle est la commande pour afficher l’état Terraform sous forme lisible ?**  
**Réponse : A. `terraform show`.**  
Elle affiche l’état Terraform actuel dans un format lisible.

---

**Total : /30**  
Cela couvre les bases et concepts intermédiaires avec des explications détaillées pour chaque réponse. 😊
