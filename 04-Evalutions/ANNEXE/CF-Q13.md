
### **Exemple complet : éviter la duplication avec `Functions`**

Dans AWS CloudFormation, les **Functions** (ou fonctions intrinsèques) permettent de réutiliser des parties du modèle, calculer des valeurs dynamiques et éviter de répéter les mêmes blocs de code. Les fonctions comme `Ref`, `Sub`, et `Fn::Join` sont couramment utilisées pour construire des modèles dynamiques et réduire la duplication.

---

#### **Exemple de modèle YAML :**
Imaginons un modèle CloudFormation où nous définissons plusieurs ressources utilisant un chemin S3 commun. Sans les fonctions, nous devrions répéter ce chemin partout.

##### **Sans fonctions : duplication de code**
```yaml
Resources:
  Bucket1:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: my-app-bucket-1

  Bucket2:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: my-app-bucket-2
```

Ici, les noms des buckets sont définis directement dans chaque ressource, ce qui duplique l'information.

---

##### **Avec `Fn::Sub` pour éviter la duplication**
```yaml
Parameters:
  Environment:
    Type: String
    Default: dev

Resources:
  Bucket1:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: !Sub my-app-bucket-1-${Environment}

  Bucket2:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: !Sub my-app-bucket-2-${Environment}
```

**Explications :**
1. **Paramètres réutilisables :**
   - On définit un paramètre nommé `Environment`, avec la valeur par défaut `dev`.
   - Ce paramètre peut être utilisé partout dans le modèle.

2. **Fonction `!Sub` :**
   - La fonction intrinsèque `!Sub` permet de substituer des variables `${}` dans des chaînes de caractères.
   - Cela évite de répéter manuellement les informations liées à l’environnement.

---

##### **Avantages :**
- **Réduction de la duplication** : Plus besoin d'écrire "dev" ou "prod" à plusieurs endroits.
- **Facilité de mise à jour** : Changer un paramètre met à jour toutes les ressources qui l'utilisent.
- **Modèles dynamiques** : Adaptabilité aux environnements différents (dev, staging, prod).


