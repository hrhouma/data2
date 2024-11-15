# **Quiz : AWS CloudFormation**  

#### **Instructions :**  
Répondez à chaque question en choisissant la meilleure réponse. Chaque question vaut 1 point. Bonne chance !

---

### **1. Que permet de faire AWS CloudFormation ?**  
- A. Déployer des applications sans serveur.  
- B. Gérer les infrastructures AWS en tant que code.  
- C. Optimiser les coûts des services AWS.  
- D. Automatiser les sauvegardes des données AWS.  

---

### **2. Quels formats sont acceptés pour écrire des modèles CloudFormation ?**  
- A. YAML et JSON  
- B. XML et CSV  
- C. TXT et XML  
- D. YAML et XML  

---

### **3. Quelle section d’un modèle est obligatoire ?**  
- A. `Resources`  
- B. `Outputs`  
- C. `Parameters`  
- D. `Conditions`  

---

### **4. Qu’est-ce qu’une Stack dans CloudFormation ?**  
- A. Un ensemble de paramètres pour configurer une application AWS.  
- B. Une collection de ressources AWS définies dans un modèle CloudFormation.  
- C. Une instance EC2 dédiée à CloudFormation.  
- D. Une fonction Lambda utilisée pour automatiser les tâches.  

---

### **5. Quelle commande CLI permet de créer une stack CloudFormation ?**  
- A. `aws cloudformation deploy-stack`  
- B. `aws cloudformation create-stack`  
- C. `aws cloudformation add-resources`  
- D. `aws cloudformation build-stack`  

---

### **6. Quelle commande CLI est utilisée pour vérifier un modèle CloudFormation ?**  
- A. `aws cloudformation validate-template`  
- B. `aws cloudformation check-template`  
- C. `aws cloudformation test-model`  
- D. `aws cloudformation analyze-template`  

---

### **7. Quelle section d’un modèle est utilisée pour spécifier des sorties visibles après la création de la stack ?**  
- A. `Resources`  
- B. `Outputs`  
- C. `Parameters`  
- D. `Metadata`  

---

### **8. Que fait l’attribut `DependsOn` ?**  
- A. Définit une ressource optionnelle dans un modèle.  
- B. Spécifie une dépendance entre deux ressources.  
- C. Automatiquement déploie toutes les ressources enfants.  
- D. Permet d’ajouter des conditions à une ressource.  

---

### **9. Quel statut de stack indique qu'une erreur s'est produite lors de la création ?**  
- A. `CREATE_COMPLETE`  
- B. `ROLLBACK_IN_PROGRESS`  
- C. `CREATE_FAILED`  
- D. `STACK_ERROR`  

---

### **10. Quelle section d’un modèle CloudFormation contient les descriptions des ressources AWS à créer ?**  
- A. `Resources`  
- B. `Outputs`  
- C. `Mappings`  
- D. `Conditions`  

---

### **11. Que signifie le terme "Infrastructure as Code" ?**  
- A. Écrire du code pour optimiser les applications.  
- B. Utiliser du code pour gérer les ressources et infrastructures informatiques.  
- C. Automatiser le déploiement d’applications sur AWS.  
- D. Créer des scripts Bash pour déployer des instances EC2.  

---

### **12. Quel est l’objectif principal des paramètres (`Parameters`) dans un modèle CloudFormation ?**  
- A. Automatiser la création des ressources.  
- B. Fournir des entrées dynamiques au modèle.  
- C. Organiser les ressources par catégories.  
- D. Simplifier les dépendances entre les ressources.  

---

### **13. Quelle fonctionnalité permet d'éviter la duplication de code dans les modèles CloudFormation ?**  
- A. `Outputs`  
- B. `Mappings`  
- C. `Conditions`  
- D. `Functions`  

---

### **14. Quel élément peut être utilisé pour insérer des valeurs dynamiques dans un modèle CloudFormation ?**  
- A. `!Ref`  
- B. `!Output`  
- C. `!DynamicValue`  
- D. `!Resource`  

---

### **15. Quelle est l’utilité principale de la section `Outputs` dans un modèle ?**  
- A. Ajouter des paramètres d'entrée pour la stack.  
- B. Fournir des informations après la création de la stack.  
- C. Configurer les dépendances entre les ressources.  
- D. Déployer des fonctions Lambda automatiquement.  

---

### **16. Quelle fonction intrinsèque est utilisée pour obtenir une valeur à partir de la section `Parameters` ?**  
- A. `!GetAtt`  
- B. `!Ref`  
- C. `!Join`  
- D. `!FindInMap`  

---

### **17. Comment CloudFormation gère-t-il les erreurs lors de la création d’une stack ?**  
- A. Il interrompt la création et enregistre un journal des erreurs.  
- B. Il effectue un rollback pour annuler les modifications.  
- C. Il termine la création en ignorant les ressources échouées.  
- D. Il recrée les ressources automatiquement.  

---

### **18. Que fait la fonction `!Join` dans un modèle CloudFormation ?**  
- A. Combine deux stacks en une seule.  
- B. Concatène une liste de valeurs en une seule chaîne de caractères.  
- C. Fusionne les dépendances entre deux ressources.  
- D. Crée une nouvelle condition.  

---

### **19. Quelle ressource AWS peut être configurée avec CloudFormation ?**  
- A. Instances EC2  
- B. Buckets S3  
- C. Groupes de sécurité  
- D. Toutes les réponses ci-dessus  

---

### **20. Quelle section du modèle permet de définir des configurations pour des environnements spécifiques (ex : régions AWS) ?**  
- A. `Mappings`  
- B. `Conditions`  
- C. `Resources`  
- D. `Outputs`  

---

### **21. Quelle fonction intrinsèque permet de récupérer une valeur dans la section `Mappings` ?**  
- A. `!Ref`  
- B. `!FindInMap`  
- C. `!GetAtt`  
- D. `!Select`  

---

### **22. Quelle est la meilleure pratique pour utiliser les modèles CloudFormation dans un projet d’entreprise ?**  
- A. Toujours réutiliser les mêmes modèles sans les modifier.  
- B. Versionner les modèles dans un système de contrôle de version.  
- C. Utiliser uniquement le format JSON pour une meilleure compatibilité.  
- D. Créer des modèles séparés pour chaque région AWS.  

---

### **23. Que signifie "Change Set" dans CloudFormation ?**  
- A. Un ensemble de modifications enregistrées pour une stack.  
- B. Une mise à jour automatique de toutes les ressources d’une stack.  
- C. Une méthode pour restaurer une stack supprimée.  
- D. Une configuration spéciale pour les ressources EC2.  

---

### **24. Que fait la fonction `!GetAtt` dans un modèle ?**  
- A. Récupère les attributs d’une ressource AWS.  
- B. Ajoute une dépendance entre deux ressources.  
- C. Fusionne plusieurs stacks dans une région AWS.  
- D. Récupère des valeurs des paramètres d’entrée.  

---

### **25. Quel service AWS permet de visualiser graphiquement un modèle CloudFormation ?**  
- A. AWS Designer  
- B. AWS Visualizer  
- C. AWS CloudFormation Designer  
- D. AWS Template Studio  

---

### **26. Quelle action est impossible avec AWS CloudFormation ?**  
- A. Déployer des fonctions Lambda.  
- B. Créer des bases de données RDS.  
- C. Configurer des règles de pare-feu.  
- D. Automatiser les tests de performance.  

---

### **27. Quel statut de stack indique que toutes les ressources ont été supprimées avec succès ?**  
- A. `DELETE_COMPLETE`  
- B. `ROLLBACK_COMPLETE`  
- C. `DELETE_SUCCESSFUL`  
- D. `STACK_DELETED`  

---

### **28. Que fait la section `Metadata` dans un modèle CloudFormation ?**  
- A. Spécifie des informations pour documenter le modèle.  
- B. Définit les configurations de sortie d’une stack.  
- C. Ajoute des dépendances entre les ressources.  
- D. Automatise les tests des ressources créées.  

---

### **29. Quelle est une des limites d’AWS CloudFormation ?**  
- A. Ne supporte pas les instances EC2.  
- B. Ne peut pas être utilisé dans toutes les régions AWS.  
- C. Les stacks ont un nombre maximal de ressources.  
- D. Les modèles doivent obligatoirement être écrits en YAML.  

---

### **30. Quelle fonctionnalité permet de mettre à jour une stack CloudFormation en minimisant les interruptions ?**  
- A. `Rolling Updates`  
- B. `Change Sets`  
- C. `Auto Updates`  
- D. `Stack Updates`  

