---
title: "Chapitre 11 - démonstration introductive de la gestion des services (pratique8)"
description: "Projet final qui combine tous les concepts appris pour déployer automatiquement une infrastructure web complète avec base de données"
emoji: "🔧"
---

# Chapitre 11 - démonstration introductive de la gestion des services (pratique8) 

---
<a name="table-des-matières"></a>
## Table des matières


# Les Services en détail partie02

# 1 - Introduction

Les Services dans Kubernetes permettent de communiquer avec un ou plusieurs Pods. Habituellement, les Pods sont éphémères et peuvent changer fréquemment d'adresse IP. Les Services fournissent une adresse IP fixe et un nom DNS pour un ensemble de Pods, et chargent également la balance du trafic vers ces Pods.

# Référence très importante:

- https://www.youtube.com/watch?v=5lzUpDtmWgM
  
# 2 - Prérequis

- Avoir installé `kubectl`.
- Avoir accès à un cluster Kubernetes.
- Avoir fait le lab précédent 03-Gestion-des-deploiments et avoir crée 1 déploiement nginx avec 3 pods avec cette section
```yaml
  template:
    metadata:
      labels:
        app: nginx
  ```
- Avoir regardé la vidéo sur les services de type nodePort :

##  https://www.youtube.com/watch?v=5lzUpDtmWgM 

# 3 - Étape 1: Création du fichier YAML pour le Service

Pour exposer le déploiement `nginx` créé précédemment, nous utiliserons un Service de type `NodePort` qui rendra l'application accessible de l'extérieur du cluster Kubernetes.

1. **Ouvrez votre éditeur de texte ou IDE**.
2. **Créez un fichier nommé** `myservice.yaml`.
3. **Ajoutez le contenu suivant au fichier** :

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30008
```


- particulièrement, cette section est importante 
```yaml
spec:
  type: NodePort
  selector:
    app: nginx
```
puisque nous allons communiquer avec les pods qui ont cette section
```yaml
  template:
    metadata:
      labels:
        app: nginx
```
- En effet, rappelez vous que dans la pratique précédente, nous avons crée ce déploiement

*mydeployment.yaml*
```ssh
kubect apply -f mydeployment.yaml
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:alpine
        ports:
        - containerPort: 80
```



# 4- Étape 2: Déploiement du Service

Déployez le Service dans votre cluster Kubernetes pour exposer le déploiement `nginx`.

- **Ouvrez un terminal**.
- **Naviguez au répertoire contenant** `myservice.yaml`.
- **Exécutez la commande** pour créer le Service :

```bash
kubectl apply -f myservice.yaml
```

# 5- Étape 3: Vérification du Service

Après avoir créé le Service, vérifiez qu'il est correctement configuré et qu'il route le trafic vers votre Pod `nginx`.

- **Pour obtenir des informations sur le Service, exécutez** :

```bash
kubectl get services
```

- **Pour obtenir des détails plus spécifiques sur le Service 'nginx-service', utilisez** :

```bash
kubectl describe service nginx-service
```


```bash
minikube ip
curl IP: 30008

```

# 6 - Conclusion

Les Services sont essentiels pour la gestion du trafic réseau dans les applications Kubernetes, fournissant un point d'accès stable aux applications dynamiques. Ce tutoriel vous a guidé à travers la création d'un Service qui expose un déploiement Nginx dans un cluster Kubernetes.

# 7 - Résumé des Commandes (IGNOREZ - ANCIEN)

```bash
# Créer le fichier YAML pour le Service
echo "
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
" > myservice.yaml

# Déployer le Service
kubectl apply -f myservice.yaml

# Lister les services pour vérifier l'état
kubectl get services

# Obtenir des détails sur le service 'nginx-service'
kubectl describe service nginx-service
```

Ce guide fournit une introduction pratique à la gestion des services dans Kubernetes, ce qui est crucial pour la production et la gestion efficace des applications.

# Annexe : 

![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/959df9b2-5064-49db-b27a-b92ae8591b2e)
![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/0af95945-6f87-435c-9fad-3cec7288a35c)
![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/65cce007-a223-4a66-a2e6-01389aea3b50)
![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/bf3a4624-f086-4af3-b289-e4af1841f5a9)
![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/127521c5-20fd-4d27-bfbe-d4ae97b7e585)
![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/57c0cadc-28c0-467b-98e4-65b77d4d9ca0)
![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/c74ac877-d536-4eeb-b7ab-c52e50476195)
![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/23c3e6f6-a79e-487c-abb5-baa8b81dd7a3)
![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/531ddaca-a64f-4c77-bc57-74df11038e8b)
![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/bcefc328-4e96-4169-829c-9b197a9c98ca)
![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/766e4314-bb5a-48e9-8880-193ec32b48c0)
![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/5dee1237-56bd-4393-8e63-58d4ac6b8ee0)
![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/be8e2ca9-b589-4769-b342-d686d9d692da)

# Cas de plusieurs noeuds
![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/8cfb853a-9991-44b0-9b14-5e36bbc3a30a)



### Partie 1 : Introduction aux Services Kubernetes

- Dans cette partie, nous allons discuter des services Kubernetes.

- Les services Kubernetes permettent la communication entre les différentes composantes de l'application, qu'elles soient internes ou externes.

- *Les services Kubernetes nous aident à connecter des applications entre elles ou avec des utilisateurs.*

- Par exemple, notre application pourrait avoir plusieurs groupes de composants exécutant différentes sections : un groupe pour servir une interface utilisateur, un autre groupe pour les processus backend, et un troisième groupe pour se connecter à une source de données externe.

-*Ce sont les services qui permettent la connectivité entre ces groupes de composants.*

- **Les services rendent l'application frontale accessible aux utilisateurs finaux, facilitent la communication entre les composants backend et frontend, et permettent la connexion à une source de données externe.**

![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/959df9b2-5064-49db-b27a-b92ae8591b2e)

- Ainsi, les services permettent un couplage lâche entre les microservices de notre application.


### Utilisation des Services

- Voyons un cas concret de l'utilisation des services.

- Jusqu'à présent, nous avons parlé de la communication entre les pods via le réseau interne.

- Examinons maintenant d'autres aspects du réseau dans cette leçon.

### Communication Externe

- Imaginons que nous ayons déployé notre pod avec une application web qui y tourne. Comment, en tant qu'utilisateur externe, pouvons-nous accéder à cette page web ?

#### Configuration Existante

- Le nœud Kubernetes a une adresse IP, par exemple 192.168.1.2. Mon ordinateur portable est sur le même réseau avec l'adresse IP 192.168.1.10. Le réseau interne des pods est dans la plage 10.240.0.0, et le pod a une adresse IP 10.240.0.2.

- Il est clair que je ne peux pas pinger ou accéder directement au pod à l'adresse 10.240.0.2 car il se trouve sur un réseau séparé.
![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/0af95945-6f87-435c-9fad-3cec7288a35c)

## Solution: 
![image](https://github.com/hrhouma/beginingKubernetes-part2/assets/10111526/65cce007-a223-4a66-a2e6-01389aea3b50)

#### Options pour Voir la Page Web

- Premièrement, si nous nous connectons au nœud Kubernetes à l'adresse 192.168.1.2, depuis ce nœud, nous pourrions accéder à la page web du pod en utilisant une commande curl ou en ouvrant un navigateur et en accédant à l'adresse http://10.240.0.2.

- Cependant, cela se fait depuis l'intérieur du nœud Kubernetes, et ce n'est pas ce que nous voulons. Nous souhaitons accéder au serveur web depuis notre propre ordinateur sans avoir à nous connecter au nœud, simplement en accédant à l'IP du nœud Kubernetes.

- Nous avons donc besoin de quelque chose pour mapper les requêtes de notre ordinateur au nœud, puis du nœud au pod exécutant le conteneur web. C'est là qu'interviennent les services Kubernetes.

### Types de Services Kubernetes

Le service Kubernetes est un objet, tout comme les pods, les réplicasets ou les déploiements que nous avons utilisés auparavant. Un de ses cas d'utilisation est d'écouter un port sur le nœud et de transférer les requêtes de ce port à un port sur le pod exécutant l'application web.

#### NodePort

- Ce type de service est appelé NodePort, car le service écoute un port sur le nœud et transfère les requêtes à ce port.

#### ClusterIP

- Le deuxième type de service est le ClusterIP. Dans ce cas, le service crée une IP virtuelle à l'intérieur du cluster pour permettre la communication entre différents services, comme un ensemble de serveurs frontend et un ensemble de serveurs backend.

#### LoadBalancer

- Le troisième type est le LoadBalancer, où il provisionne un équilibrage de charge pour notre application sur des fournisseurs de cloud supportés, comme pour distribuer la charge entre différents serveurs web dans la couche frontend.

### Création d'un Service NodePort

- Revenons à NodePort, nous avons discuté de l'accès externe à l'application. Nous avons dit qu'un service peut nous aider en mappant un port sur le nœud à un port sur le pod.

- Regardons de plus près le service. Il y a trois ports impliqués :

1. Le port sur le pod où le serveur web s'exécute, appelé port cible (target port), généralement 80.
2. Le port sur le service lui-même, simplement appelé port.
3. Le port sur le nœud, appelé NodePort, par exemple 30008.

- Nous créons un service en utilisant un fichier de définition, comme nous l'avons fait pour les déploiements, les réplicasets ou les pods. La structure du fichier reste la même : API version, kind, metadata et spec.

- La version de l'API est v1.
- Le kind est Service.
- Les metadata incluent le nom du service.
- La section spec est cruciale : on y définit les ports et le type de service (NodePort).

## Sous ports, nous définissons :
- Le port cible (target port), 80.
- Le port du service, 80.
- Le NodePort, par exemple 30008.

- Il manque encore une chose : connecter le service au pod. Nous utilisons des labels et des sélecteurs pour cela. Nous ajoutons les labels du pod dans la section selector du fichier de définition du service.

- Une fois cela fait, nous créons le service avec la commande `kubectl create` et vérifions avec `kubectl get services`.

### Accès au Service

- Nous pouvons maintenant accéder au service web en utilisant curl ou un navigateur avec l'adresse IP du nœud et le NodePort.

- Pour résumer, que ce soit un pod unique, plusieurs pods sur un même nœud, ou plusieurs pods sur plusieurs nœuds, le service est créé de la même manière sans étapes supplémentaires.



# Partie 2 : Démonstration des Services Kubernetes

Dans cette démonstration, nous allons examiner les services dans Kubernetes et reprendre là où nous nous étions arrêtés lors de la précédente démonstration.

Nous avons créé quelques pods en créant un déploiement, alors vérifions d'abord le statut de ce déploiement.

Nous avons un déploiement appelé "my-app-deployment" avec six réplicas, ce qui signifie essentiellement que six pods fonctionnent dans le cluster Kubernetes.

Nous avons maintenant une application créée pour s'exécuter sur ce cluster. Cependant, pour que l'utilisateur final puisse y accéder via son navigateur web, nous devons créer un service.

Pour ce faire, revenons à notre éditeur.

Nous avons créé un nouveau répertoire appelé "Service". Dans ce répertoire "Service", nous allons créer un nouveau fichier appelé "service-definition.yaml".

Notez que vous n'avez pas besoin de suivre cette structure de répertoire comme je le fais. Je le fais simplement pour organiser les exemples. Vous pourriez simplement avoir tous les fichiers au même endroit.

### Création du Fichier de Définition du Service

Comme précédemment, la première chose à ajouter est l'élément racine, la version de l'API. Pour un service, elle doit être définie à "v1". Pour le type (kind), nous allons spécifier "Service".

Ensuite, nous allons ajouter les métadonnées avec le nom du service que nous pouvons appeler "my-app-service".

Sous cela, nous allons ajouter la section des spécifications (spec). La première propriété que nous allons créer est le type de service, que nous allons définir comme "NodePort".

Notre objectif est de pouvoir accéder à notre application sur un port du nœud, qui est le nœud Minikube dans notre cas.

Nous allons ensuite ajouter le port et le port par défaut sur lequel Nginx écoute, qui est 80. Nous allons également ajouter notre port cible (target port), qui est également le port 80.

Il s'agit essentiellement du port sur le service lui-même.

Ensuite, nous allons ajouter un NodePort que nous pouvons définir à une valeur telle que 30004. Cela pourrait être n'importe quelle valeur entre 30000 et 32767.

Ce NodePort est le port sur le nœud, le nœud de travail, qui est le nœud Minikube sur lequel l'application sera accessible.

Ensuite, nous allons ajouter un sélecteur (selector) qui nous aide à lier notre service au pod avec la même étiquette.

### Vérification du Fichier de Déploiement

Jetons rapidement un coup d'œil au fichier YAML de déploiement et vous remarquerez que l'étiquette pour le pod est "app" avec la valeur "my-app".

Ajoutons cette même valeur ici sous la section "selector".

### Finalisation du Fichier de Définition du Service

Une fois cela terminé, notre fichier de définition de service est complet et nous pouvons procéder à sa création sur nos clusters.

Je vais le sauvegarder ici et revenir à mon terminal. Je vais naviguer vers le nouveau répertoire que nous avons créé, où se trouve notre fichier de définition de service.

Je vais créer le service en utilisant la commande `kubectl create` avec l'option `-f` et spécifier le fichier de définition du service en entrée.

Je lance cette commande et le service a été créé.

Nous pouvons maintenant exécuter la commande `kubectl get services` et vous remarquerez que le nouveau service est visible. Le type du service est "NodePort", car nous voulons qu'il soit accessible sur le port du nœud de travail.

Voici l'adresse IP du cluster qui est également créée pour le service. Il s'agit d'une adresse créée pour le service dans le réseau interne du cluster.

Voici le port sur le nœud de travail que nous pouvons utiliser pour accéder à notre application. Si vous connaissez l'adresse IP du nœud de travail, vous pouvez simplement aller sur un navigateur, taper l'adresse IP du nœud de travail suivie du numéro de port, et vous devriez pouvoir accéder à cette application.

### Utilisation de Minikube

Comme nous exécutons cela sur Minikube, nous pouvons également utiliser la commande `minikube service` suivie du nom du service, qui est "my-app-service", et utiliser l'option `--url`. Cela devrait nous donner l'URL où le service est disponible.

Essayons d'accéder à cela sur un navigateur. Vous pouvez simplement copier cette URL, aller sur un navigateur et coller cette URL dans le navigateur. Nous voyons alors la page web par défaut de Nginx, ce qui confirme que l'application Nginx est opérationnelle et accessible via un navigateur web.

C'est tout pour cette démonstration. Je vous retrouverai dans la prochaine leçon.

### Partie 3 : ClusterIP

Bonjour et bienvenue dans ce cours.

Dans cette leçon, nous allons discuter du service ClusterIP de Kubernetes.

Une application web full-stack a généralement différents types de pods hébergeant différentes parties de l'application.

Vous pouvez avoir plusieurs pods exécutant un serveur web frontend, un autre ensemble de pods exécutant un serveur backend, un ensemble de pods exécutant un store clé-valeur comme Redis et un autre ensemble de pods exécutant une base de données persistante comme MySQL.

Le serveur web frontend doit communiquer avec les serveurs backend, et ces derniers doivent communiquer avec la base de données ainsi que les services Redis, etc.

### Connectivité entre les Services

Les pods ont tous une adresse IP qui leur est attribuée, comme nous pouvons le voir à l'écran. Cependant, ces adresses IP ne sont pas statiques. Les pods peuvent tomber à tout moment et de nouveaux pods sont créés en permanence, donc vous ne pouvez pas vous fier à ces adresses IP pour la communication interne entre les composants de l'application.

De plus, si le premier pod frontend à l'adresse 10.240.0.3 doit se connecter à un service backend, lequel des trois doit-il choisir et qui prend cette décision ?

Un service Kubernetes peut nous aider à regrouper les pods et à fournir une interface unique pour accéder aux pods d'un groupe.

### Exemple de Service Backend

Par exemple, un service créé pour les pods backend regroupera tous les pods backend et fournira une interface unique pour que d'autres pods puissent accéder à ce service. Les requêtes sont transférées de manière aléatoire à l'un des pods sous le service.

De même, vous pouvez créer des services supplémentaires pour Redis et permettre aux pods backend d'accéder aux systèmes Redis via le service. Cela nous permet de déployer facilement et efficacement une application basée sur des microservices sur un cluster Kubernetes.

Chaque couche peut maintenant s'adapter ou se déplacer selon les besoins sans impacter la communication entre les différents services.

### Création d'un Service ClusterIP

Chaque service obtient une IP et un nom attribués à l'intérieur du cluster, et c'est ce nom qui doit être utilisé par les autres pods pour accéder au service. Ce type de service est connu sous le nom de ClusterIP.

Pour créer un tel service, utilisez comme toujours un fichier de définition. Dans ce fichier de définition de service, utilisez le modèle par défaut avec les sections API version, kind, metadata et spec.

- La version de l'API est "v1".
- Le type est "Service".
- Donnez un nom à votre service, par exemple "backend".

Sous la spécification, nous avons le type et les ports. Le type est ClusterIP. En fait, ClusterIP est le type par défaut, donc même si vous ne le spécifiez pas, il assumera automatiquement ce type.

Sous la section ports, nous avons le targetPort et le port. Le targetPort est le port où le backend est exposé, dans ce cas 80, et le port est celui où le service est exposé, qui est également 80.

Pour lier le service à un ensemble de pods, nous utilisons un sélecteur. Nous référons au fichier de définition des pods, copions les labels de celui-ci et les plaçons sous la section selector.

### Création et Vérification du Service

- Nous pouvons maintenant créer le service en utilisant la commande `kubectl create` et vérifier son statut avec la commande `kubectl get services`.
- Le service peut être accessible par d'autres pods en utilisant le ClusterIP ou le nom du service.



### Partie 4 : LoadBalancer

- Nous allons maintenant examiner un autre type de service connu sous le nom de LoadBalancer.

- Nous avons déjà vu le service NodePort qui nous permet de rendre une application externe accessible sur un port des nœuds de travail. Concentrons-nous maintenant sur les applications frontend, comme l'application de vote et l'application de résultats.

- Ces pods sont hébergés sur les nœuds de travail dans un cluster. Supposons que nous ayons un cluster de quatre nœuds et que nous voulions rendre les applications accessibles aux utilisateurs externes en créant des services de type NodePort.

### Accessibilité avec NodePort

- Les services de type NodePort permettent de recevoir le trafic sur les ports des nœuds et de le rediriger vers les pods respectifs. Mais quelle URL donneriez-vous à vos utilisateurs pour accéder aux applications ?

- Vous pourriez accéder à n'importe laquelle de ces deux applications en utilisant l'IP de n'importe lequel des nœuds et le port élevé sur lequel le service est exposé. Cela signifie que vous auriez quatre combinaisons d'IP et de port pour l'application de vote et quatre combinaisons d'IP et de port pour l'application de résultats.

- Même si vos pods sont uniquement hébergés sur deux des nœuds, ils seront toujours accessibles via les IP de tous les nœuds du cluster. Par exemple, si les pods de l'application de vote ne sont déployés que sur les nœuds avec les IP 70 et 71, ils seront toujours accessibles sur les ports de tous les nœuds du cluster.

### Besoin d'une URL Unique

- Pourtant, ce n'est pas ce que les utilisateurs finaux souhaitent. Ils ont besoin d'une URL unique, comme par exemple `voting.abc.com` ou `result.abc.com`, pour accéder à l'application. Comment y parvenir ?
  
- Une façon d'y parvenir est de créer une nouvelle machine virtuelle pour le load balancer, d'y installer et de configurer un load balancer approprié comme HAProxy ou NGINX, puis de configurer le load balancer pour rediriger le trafic vers les nœuds sous-jacents.

### Utilisation des Load Balancers Natifs des Clouds

- Cependant, configurer tout cela et ensuite maintenir et gérer le load balancer externe peut être une tâche fastidieuse. Si nous étions sur une plateforme cloud supportée comme Google Cloud, AWS ou Azure, nous pourrions tirer parti du load balancer natif de cette plateforme cloud.

- Kubernetes prend en charge l'intégration avec les load balancers natifs de certains fournisseurs de cloud et peut configurer cela pour nous. Il suffit de définir le type de service pour les services frontend en tant que LoadBalancer au lieu de NodePort.

### Environnements Supportés

- Il est important de noter que cela ne fonctionne que sur des plateformes cloud supportées. GCP, AWS et Azure sont définitivement supportés. Si vous définissez le type de service en tant que LoadBalancer dans un environnement non supporté comme VirtualBox ou d'autres environnements, cela aura le même effet que de le définir en tant que NodePort, où les services sont exposés sur un port élevé sur les nœuds. Il n'y aura simplement pas de configuration de load balancer externe.

- Lorsque nous passerons en revue les démonstrations de déploiement de notre application sur des plateformes cloud, nous verrons cela en action.



