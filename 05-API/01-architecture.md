----------------------------------------------------
# Partie 01 - Architecture du projet
----------------------------------------------------

```
monchatbot/
├── chatbot_frontend/                  # Projet React (Frontend)
│   ├── node_modules/                  # Dépendances de Node.js
│   ├── public/                        # Fichiers publics de React
│   ├── src/                           # Code source React
│   │   ├── App.js                     # Composant principal React
│   │   ├── Chatbot.js                 # Composant de l'interface utilisateur pour le chatbot
│   │   ├── index.js                   # Point d'entrée React
│   │   ├── App.css                    # Style principal de l'application
│   │   ├── index.css                  # CSS global
│   │   └── ...                        # Autres fichiers React
│   ├── package.json                   # Dépendances et scripts pour React
│   ├── package-lock.json              # Verrouillage des versions de dépendances
│   └── README.md                      # Documentation du projet React
│
├── chatbot_project/                   # Projet Django (Backend)
│   ├── chatbot_app/                   # Application Django principale
│   │   ├── migrations/                # Fichiers de migration de la base de données
│   │   ├── __init__.py                # Fichier d'initialisation du module Python
│   │   ├── admin.py                   # Configuration de l'administration Django
│   │   ├── apps.py                    # Configuration de l'application Django
│   │   ├── models.py                  # Modèles de base de données Django
│   │   ├── tests.py                   # Tests unitaires pour l'application
│   │   └── views.py                   # Vues (Logique des réponses API)
│   │
│   ├── chatbot_project/               # Répertoire de configuration du projet Django
│   │   ├── __init__.py                # Fichier d'initialisation du module Python
│   │   ├── settings.py                # Fichier de configuration principale de Django
│   │   ├── urls.py                    # Routes principales du projet Django
│   │   ├── asgi.py                    # Configuration pour ASGI
│   │   └── wsgi.py                    # Configuration pour WSGI
│   │
│   ├── manage.py                      # Script principal pour les commandes Django
│   ├── db.sqlite3                     # Base de données SQLite par défaut
│   └── env/                           # Environnement virtuel Python (non visible dans le dépôt)
│
└── README.md                          # Documentation générale du projet
```

### **Explication des composants :**

1. **`chatbot_frontend/`** :
   - Contient tout le code React pour le frontend de l'application.
   - Le fichier `Chatbot.js` gère l'interface utilisateur pour envoyer des messages et afficher les réponses du chatbot.
   - Le fichier `App.js` intègre le composant `Chatbot` comme élément principal de l'application.

2. **`chatbot_project/`** :
   - Le projet Django héberge le backend qui gère les requêtes API et les interactions avec l'API OpenAI.
   - L'application `chatbot_app/` contient la logique spécifique pour le chatbot (dans `views.py`).

3. **`manage.py`** :
   - Commande centrale pour exécuter et gérer le projet Django (lancer le serveur, appliquer les migrations, etc.).

4. **Base de données (`db.sqlite3`)** :
   - Une base de données SQLite pour stocker des informations simples (par exemple, historique des conversations, utilisateurs, etc.).

5. **Environnement virtuel (`env/`)** :
   - Fichiers isolant les dépendances Python nécessaires au projet.


----------------------------------------------------
# Partie 2 - Organigramme de l'application:
----------------------------------------------------


### Django + React. 
- Nous illustrons les différentes couches (frontend, backend, API) et leur interaction.

```
                              +----------------------+
                              |   Utilisateur final  |
                              | (Navigateur Web)     |
                              +----------------------+
                                       |
                                       | HTTP (Requête utilisateur)
                                       v
+---------------------------------------------+
|                Frontend (React)             |
|---------------------------------------------|
| - src/                                       |
|   - App.js (Composant principal)            |
|   - Chatbot.js (Interface utilisateur)      |
| - Axios (Requêtes vers le backend)          |
+---------------------------------------------+
                                       |
                                       | API Request (HTTP POST)
                                       v
+---------------------------------------------+
|              Backend (Django)               |
|---------------------------------------------|
| - chatbot_project/                          |
|   - settings.py (Configuration globale)     |
|   - urls.py (Routes principales)            |
| - chatbot/                                  |
|   - views.py (Logique API)                  |
|   - models.py (Stockage historique, option) |
+---------------------------------------------+
                                       |
                                       | OpenAI API Call (Requête externe)
                                       v
+---------------------------------------------+
|               OpenAI (ChatGPT)              |
|---------------------------------------------|
| - Modèle GPT-3.5 ou GPT-4                   |
| - Génération des réponses                  |
+---------------------------------------------+
                                       ^
                                       | Réponse du modèle (Texte)
                                       |
+---------------------------------------------+
|              Backend (Django)               |
|---------------------------------------------+
                                       ^
                                       | API Response (HTTP Response JSON)
                                       |
+---------------------------------------------+
|                Frontend (React)             |
|---------------------------------------------+
                                       ^
                                       | Affichage de la réponse bot
                                       |
                              +----------------------+
                              |   Utilisateur final  |
                              | (Navigateur Web)     |
                              +----------------------+
```

### **Détails des composants**
1. **Frontend (React)** :
   - Reçoit les messages de l'utilisateur.
   - Envoie les messages au backend via Axios (API REST).
   - Affiche la réponse du chatbot.

2. **Backend (Django)** :
   - Traite les requêtes de l'utilisateur via des routes (API).
   - Envoie le message à l'API OpenAI.
   - Retourne la réponse générée au frontend.

3. **OpenAI API** :
   - Reçoit les messages envoyés par Django.
   - Génère une réponse basée sur le modèle GPT-3.5/GPT-4.
   - Retourne la réponse au backend.

### **Flux des données**
1. **Utilisateur → React** : L'utilisateur saisit un message.
2. **React → Django (API)** : Le message est envoyé au backend.
3. **Django → OpenAI** : Le backend appelle l'API OpenAI pour générer une réponse.
4. **OpenAI → Django** : L'API OpenAI retourne la réponse générée.
5. **Django → React** : La réponse est renvoyée au frontend.
6. **React → Utilisateur** : La réponse est affichée à l'utilisateur final.


