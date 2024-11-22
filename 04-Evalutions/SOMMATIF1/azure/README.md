# Guide Azure : Analyse et compréhension de la configuration Terraform pour Azure

---

**Introduction** :  
Dans cet exercice, vous êtes invités à **lire, commenter et analyser** les fichiers de configuration Terraform fournis pour Azure. Votre objectif principal est de répondre aux questions à choix multiples et d'expliquer chaque composant des fichiers.

---

### Fichiers fournis à analyser

#### **1. `main.tf`**
- Ce fichier définit les ressources à créer sur Microsoft Azure, comme des machines virtuelles, des réseaux virtuels et des comptes de stockage.
- À vous d'identifier l'objectif de chaque section, de commenter et d'expliquer pourquoi ce fichier est essentiel dans une configuration Terraform.

#### **2. `variables.tf`**
- Contient les variables utilisées dans `main.tf`, comme le nom du groupe de ressources, la région, la taille de la machine virtuelle, etc.
- Analysez la structure et expliquez l'intérêt d'utiliser des variables dans une configuration.

#### **3. Exemple de ressources**  
   - **Groupe de ressources :**  
   ```hcl
   resource "azurerm_resource_group" "example" {
     name     = var.resource_group_name
     location = var.location
   }
   ```
   - **Machine virtuelle Linux :**  
   ```hcl
   resource "azurerm_linux_virtual_machine" "example" {
     name                = "${var.resource_group_name}-vm"
     resource_group_name = azurerm_resource_group.example.name
     location            = azurerm_resource_group.example.location
     size                = var.vm_size
     admin_username      = var.admin_username
     admin_password      = var.admin_password
     network_interface_ids = [
       azurerm_network_interface.example.id,
     ]

     os_disk {
       caching              = "ReadWrite"
       storage_account_type = "Premium_LRS"
     }

     source_image_reference {
       publisher = "Canonical"
       offer     = "UbuntuServer"
       sku       = "18.04-LTS"
       version   = "latest"
     }
   }
   ```

#### **4. Outputs**
   - Analysez les `outputs` comme :  
   ```hcl
   output "vm_ip_address" {
     value = azurerm_linux_virtual_machine.example.public_ip_address
   }
   ```
   - Commentez l'utilité de ces sorties dans une configuration Terraform.

---

### Quiz à choix multiples (10 questions)

1. **Que contient le fichier `main.tf` et pourquoi est-il important ?**  
   a) Les paramètres de configuration globaux d'Azure.  
   b) Les ressources Azure à déployer.  
   c) Les logs de Terraform.  
   d) Le code PowerShell pour Azure.  

2. **Quelle est la fonction de `variables.tf` dans une configuration Terraform pour Azure ?**  
   a) Stocker les secrets Azure.  
   b) Définir des valeurs codées en dur pour toutes les ressources.  
   c) Centraliser les paramètres pour une meilleure réutilisabilité.  
   d) Gérer les abonnements Azure.  

3. **Quel est le rôle de la ressource `azurerm_resource_group` ?**  
   a) Créer un groupe logique pour les ressources Azure.  
   b) Définir les règles de pare-feu.  
   c) Configurer le réseau virtuel.  
   d) Gérer les utilisateurs Azure AD.  

4. **Pourquoi utilise-t-on des variables comme `var.location` au lieu de valeurs codées en dur ?**  
   a) Pour accélérer le déploiement.  
   b) Pour simplifier la personnalisation et la maintenance.  
   c) Pour respecter les quotas Azure.  
   d) Pour crypter les données sensibles.  

5. **Que représente le bloc `os_disk` dans la ressource `azurerm_linux_virtual_machine` ?**  
   a) Le réseau associé à la VM.  
   b) Le disque du système d'exploitation de la VM.  
   c) Les paramètres de sauvegarde.  
   d) La configuration du pare-feu de la VM.  

6. **Quelle est l'importance du bloc `source_image_reference` dans la configuration de la VM ?**  
   a) Définir l'image du système d'exploitation à utiliser.  
   b) Configurer l'accès SSH.  
   c) Spécifier les paramètres de mise à l'échelle.  
   d) Définir les règles de pare-feu.  

7. **Dans la ressource `azurerm_storage_account`, que signifie `account_replication_type` ?**  
   a) Le type d'authentification du compte.  
   b) Le type de réplication des données du compte de stockage.  
   c) Le niveau de performance du stockage.  
   d) Le type de chiffrement utilisé.  

8. **Quels sont les avantages d'utiliser un output comme `vm_ip_address` ?**  
   a) Fournir des informations utiles après le déploiement.  
   b) Accélérer la création de la VM.  
   c) Générer automatiquement des mots de passe sécurisés.  
   d) Configurer le DNS Azure.  

9. **Pourquoi le fichier `variables.tf` inclut-il une valeur par défaut pour certaines variables comme `location` ?**  
   a) Pour éviter les erreurs si l'utilisateur ne fournit pas de valeur.  
   b) Pour forcer l'utilisation d'une région spécifique.  
   c) Pour réduire les coûts Azure.  
   d) Pour respecter les politiques de conformité Azure.  

10. **Quelle commande Terraform utiliseriez-vous pour voir les changements prévus avant de les appliquer ?**  
    a) `terraform preview`  
    b) `terraform check`  
    c) `terraform plan`  
    d) `terraform simulate`  

---

### Consignes

1. **Analysez chaque fichier** et écrivez vos commentaires en réponse à chaque composant.
2. **Répondez au quiz** en justifiant vos choix.
3. Soyez concis mais précis. Montrez une compréhension approfondie de chaque aspect de la configuration Azure avec Terraform.

Bonne chance ! 🎓
