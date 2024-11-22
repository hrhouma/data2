# Guide de GCP : Analyse et compréhension de la configuration Terraform pour GCP

---

**Introduction** :  
Dans cet exercice, vous êtes invités à **lire, commenter et analyser** les fichiers de configuration Terraform fournis. Votre objectif principal est de répondre aux questions à choix multiples et d'expliquer chaque composant des fichiers.

---

### Fichiers fournis à analyser

#### **1. `main.tf`**
- Ce fichier définit les ressources à créer sur Google Cloud Platform (GCP), comme des instances **Compute Engine** et des buckets **Cloud Storage**.
- À vous d'identifier l'objectif de chaque section, de commenter et d'expliquer pourquoi ce fichier est essentiel dans une configuration Terraform.

#### **2. `variables.tf`**
- Contient les variables utilisées dans `main.tf`, comme le projet, la région, le type de machine, etc.
- Analysez la structure et expliquez l’intérêt d'utiliser des variables dans une configuration.

#### **3. Exemple de ressources**  
   - **Instance Compute Engine :**  
   ```hcl
   resource "google_compute_instance" "default" {
     name         = var.instance_name
     machine_type = var.machine_type
     zone         = var.zone

     boot_disk {
       initialize_params {
         image = var.image
       }
     }

     network_interface {
       network = "default"
       access_config {}
     }

     metadata = {
       ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key)}"
     }
   }
   ```
   - **Bucket Cloud Storage :**  
   ```hcl
   resource "google_storage_bucket" "default" {
     name     = var.bucket_name
     location = var.bucket_location
   }
   ```

#### **4. Outputs**
   - Analysez les `outputs` comme :  
   ```hcl
   output "instance_ip" {
     value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
   }
   ```
   - Commentez l’utilité de ces sorties dans une configuration Terraform.

---

### Quiz à choix multiples (10 questions)

1. **Qu’est-ce que le fichier `main.tf` contient et pourquoi est-il important ?**  
   a) Les paramètres de configuration globaux.  
   b) Les ressources à déployer.  
   c) Les logs de Terraform.  
   d) Le code Python.  

2. **Quelle est la fonction de `variables.tf` dans une configuration Terraform ?**  
   a) Sauvegarder les ressources créées.  
   b) Fournir des valeurs codées en dur pour toutes les ressources.  
   c) Centraliser les paramètres pour une meilleure réutilisabilité.  
   d) Supprimer les ressources créées.  

3. **Expliquez l’objectif de la commande `terraform plan`.**  
   a) Déployer immédiatement les ressources.  
   b) Vérifier les modifications avant leur application.  
   c) Créer un bucket Cloud Storage.  
   d) Ajouter des permissions utilisateur.  

4. **Pourquoi est-il recommandé d’utiliser des variables au lieu de valeurs codées en dur dans Terraform ?**  
   a) Pour rendre la configuration plus rapide.  
   b) Pour simplifier la personnalisation et la maintenance.  
   c) Pour limiter les erreurs lors de l’exécution.  
   d) Les deux dernières réponses.  

5. **Que représente le bloc `boot_disk` dans la ressource `google_compute_instance` ?**  
   a) Le réseau associé à l’instance.  
   b) Le disque de démarrage de l’instance.  
   c) L’accès SSH.  
   d) La clé de chiffrement du projet.  

6. **Quelle est l’importance de définir une clé SSH dans `metadata` pour l’instance ?**  
   a) Configurer l’accès sécurisé à l’instance.  
   b) Chiffrer les données.  
   c) Ajouter des API externes.  
   d) Sauvegarder les journaux système.  

7. **Dans `google_storage_bucket`, que signifie `location` ? Pourquoi est-ce important ?**  
   a) L’adresse IP du bucket.  
   b) La région où le bucket sera créé.  
   c) Le nom de domaine associé.  
   d) La liste des utilisateurs ayant accès.  

8. **Quels sont les avantages d’utiliser les outputs comme `instance_ip` et `bucket_url` ?**  
   a) Fournir des informations utiles pour d’autres configurations.  
   b) Permettre un déploiement plus rapide.  
   c) Générer automatiquement des clés SSH.  
   d) Chiffrer les données sensibles.  

9. **Pourquoi le fichier `variables.tf` inclut-il une valeur par défaut pour certaines variables comme `region` ?**  
   a) Éviter les erreurs si l’utilisateur ne fournit pas de valeur.  
   b) Ajouter des restrictions de sécurité.  
   c) Réduire la charge sur Terraform.  
   d) Permettre des déploiements dans plusieurs régions simultanément.  

10. **Quelle est la commande à exécuter pour détruire toutes les ressources créées par Terraform ?**  
    a) `terraform delete`.  
    b) `terraform remove`.  
    c) `terraform destroy`.  
    d) `terraform teardown`.  

---

### Consignes

1. **Analysez chaque fichier** et écrivez vos commentaires en réponse à chaque composant.
2. **Répondez au quiz** en justifiant vos choix.
3. Soyez concis mais précis. Montrez une compréhension approfondie de chaque aspect. 

Bonne chance ! 🎓
