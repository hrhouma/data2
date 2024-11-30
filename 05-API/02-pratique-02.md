
## Préparation de l'environnement de développement

### Prérequis

1. Assurez-vous d'avoir installé :
   - Python (version 3.8 ou supérieure)
   - Node.js
   - Visual Studio Code (ou un autre éditeur de texte)
   - Git

### Installation des outils

1. Vérifiez vos installations :

```bash
python --version
node --version
npm --version
```

## Configuration du projet Django

### Création de l'environnement virtuel et installation de Django

1. Ouvrez un terminal et exécutez :

```bash
python -m venv env
```

2. Activez l'environnement virtuel :
   - Sur Windows :
   ```bash
   .\env\Scripts\activate
   ```
   - Sur macOS/Linux :
   ```bash
   source env/bin/activate
   ```

3. Installez Django :

```bash
pip install django
```

### Création du projet Django

1. Créez le projet :

```bash
django-admin startproject chatbot_project
cd chatbot_project
```

2. Créez l'application :

```bash
python manage.py startapp chatbot_app
```

3. Ouvrez `chatbot_project/settings.py` et ajoutez `'chatbot_app'` à `INSTALLED_APPS` :

```python
INSTALLED_APPS = [
    ...
    'chatbot_app',
]
```

## Configuration de React

### Installation de React

1. Dans un nouveau terminal, créez le projet React :

```bash
npx create-react-app chatbot_frontend
cd chatbot_frontend
```

2. Installez Axios pour les requêtes HTTP :

```bash
npm install axios
```

## Configuration de Django pour travailler avec React

1. Installez django-cors-headers :

```bash
pip install django-cors-headers
```

2. Modifiez `chatbot_project/settings.py` :

```python
INSTALLED_APPS = [
    ...
    'corsheaders',
]

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.common.CommonMiddleware',
    ...
]

CORS_ALLOWED_ORIGINS = [
    'http://localhost:3000',
]
```

## Création de l'API Django

1. Dans `chatbot_app/views.py`, ajoutez :

```python
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json

@csrf_exempt
def chatbot_response(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        user_message = data.get('message', '')
        response = f"Vous avez dit : {user_message}"
        return JsonResponse({'message': response})
    return JsonResponse({'error': 'Requête invalide'}, status=400)
```

2. Créez `chatbot_app/urls.py` et ajoutez :

```python
from django.urls import path
from .views import chatbot_response

urlpatterns = [
    path('api/chatbot/', chatbot_response, name='chatbot_response'),
]
```

3. Dans `chatbot_project/urls.py`, ajoutez :

```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('chatbot_app.urls')),
]
```

## Création de l'interface React

1. Dans le dossier `chatbot_frontend/src`, créez `Chatbot.js` :

```javascript
import React, { useState } from 'react';
import axios from 'axios';

const Chatbot = () => {
    const [messages, setMessages] = useState([]);
    const [userInput, setUserInput] = useState('');

    const sendMessage = async () => {
        if (!userInput.trim()) return;
        const newMessages = [...messages, { sender: 'user', text: userInput }];
        setMessages(newMessages);
        setUserInput('');

        try {
            const response = await axios.post('http://127.0.0.1:8000/api/chatbot/', { message: userInput });
            setMessages([...newMessages, { sender: 'bot', text: response.data.message }]);
        } catch (error) {
            console.error(error);
        }
    };

    return (
        <div>
            <h1>Chatbot</h1>
            <div>
                {messages.map((msg, index) => (
                    <p key={index} className={msg.sender}>
                        {msg.sender === 'user' ? 'Vous : ' : 'Bot : '}
                        {msg.text}
                    </p>
                ))}
            </div>
            <input
                type="text"
                value={userInput}
                onChange={(e) => setUserInput(e.target.value)}
                onKeyPress={(e) => e.key === 'Enter' && sendMessage()}
            />
            <button onClick={sendMessage}>Envoyer</button>
        </div>
    );
};

export default Chatbot;
```

2. Modifiez `App.js` :

```javascript
import React from 'react';
import Chatbot from './Chatbot';

function App() {
    return (
        <div className="App">
            <Chatbot />
        </div>
    );
}

export default App;
```

## Lancement du projet

1. Dans le terminal Django, lancez le serveur :

```bash
python manage.py runserver
```

2. Dans le terminal React, lancez l'application :

```bash
npm start
```

Votre chatbot est maintenant fonctionnel ! Vous pouvez accéder à l'interface sur [http://localhost:3000](http://localhost:3000) et commencer à interagir avec le bot.


------------------------
# Annexe 01
-------------------------

### Classes, Fichiers et Composants (Exhaustif)

Voici le contenu **complet et détaillé** de chaque fichier que vous avez mentionné, avec des explications pédagogiques pour les étudiants débutants.

---

### **1. App.js (React - Composant Principal)**

Le composant `App.js` est le point d'entrée principal de l'application React. Il inclut le composant `Chatbot` que nous avons créé séparément.

```javascript
import React from 'react';
import Chatbot from './Chatbot'; // Importation du composant Chatbot

function App() {
    return (
        <div className="App">
            {/* Ajout du composant Chatbot dans la structure de l'application */}
            <Chatbot />
        </div>
    );
}

export default App;
```

- **Explication :**
  - La fonction `App` retourne un composant React (`<Chatbot />`) encapsulé dans une `div`.
  - La classe CSS `"App"` peut être stylisée dans un fichier séparé (exemple : `App.css`).

---

### **2. Chatbot.js (React - Interface du Chatbot)**

Ce composant gère :
- Les messages échangés entre l'utilisateur et le bot.
- La logique d'envoi des messages via une API Django.

```javascript
import React, { useState } from 'react';
import axios from 'axios'; // Axios pour effectuer des requêtes HTTP

const Chatbot = () => {
    const [messages, setMessages] = useState([]); // Historique des messages
    const [userInput, setUserInput] = useState(''); // Saisie de l'utilisateur

    const sendMessage = async () => {
        if (!userInput.trim()) return; // Ignore les saisies vides

        // Ajoute le message de l'utilisateur à l'historique
        const newMessages = [...messages, { sender: 'user', text: userInput }];
        setMessages(newMessages);
        setUserInput(''); // Réinitialise la saisie

        try {
            // Envoi du message à l'API Django
            const response = await axios.post('http://127.0.0.1:8000/api/chatbot/', { message: userInput });
            // Ajoute la réponse du bot à l'historique
            setMessages([...newMessages, { sender: 'bot', text: response.data.message }]);
        } catch (error) {
            console.error(error); // Affiche les erreurs éventuelles
        }
    };

    return (
        <div>
            <h1>Chatbot</h1>
            <div>
                {/* Affiche chaque message */}
                {messages.map((msg, index) => (
                    <p key={index} className={msg.sender}>
                        {msg.sender === 'user' ? 'Vous : ' : 'Bot : '}
                        {msg.text}
                    </p>
                ))}
            </div>
            <input
                type="text"
                value={userInput} // Liaison avec l'état userInput
                onChange={(e) => setUserInput(e.target.value)} // Mise à jour de la saisie utilisateur
                onKeyPress={(e) => e.key === 'Enter' && sendMessage()} // Envoi au "Enter"
            />
            <button onClick={sendMessage}>Envoyer</button> {/* Envoi via bouton */}
        </div>
    );
};

export default Chatbot;
```

- **Explication des parties principales :**
  - **useState** : Gestion des états `messages` (historique) et `userInput` (saisie utilisateur).
  - **axios** : Requête POST à l'API Django pour obtenir la réponse du chatbot.
  - **UI** : Affiche les messages sous forme de paragraphes (`<p>`).

---

### **3. views.py (Django - Logique de l'API)**

Cette vue Django reçoit les messages de l'utilisateur via une requête POST, et retourne une réponse JSON simulée.

```python
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json

@csrf_exempt  # Désactivation de la protection CSRF pour tester plus facilement les requêtes
def chatbot_response(request):
    if request.method == 'POST':  # Vérifie si la requête est bien un POST
        data = json.loads(request.body)  # Charge le corps de la requête JSON
        user_message = data.get('message', '')  # Récupère le message utilisateur
        response = f"Vous avez dit : {user_message}"  # Génère une réponse simple
        return JsonResponse({'message': response})  # Retourne la réponse sous forme JSON
    return JsonResponse({'error': 'Requête invalide'}, status=400)
```

- **Explication des parties :**
  - `csrf_exempt` : Utilisé pour désactiver temporairement la vérification CSRF (utile pour les tests locaux).
  - `JsonResponse` : Retourne une réponse en JSON lisible par le frontend.
  - `POST` : Traite uniquement les requêtes POST.

---

### **4. settings.py (Django - Configuration)**

Voici le fichier de configuration ajusté pour activer **corsheaders** et l’application `chatbot_app`.

```python
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "corsheaders",  # Middleware pour autoriser les requêtes cross-origin
    "chatbot_app",  # Notre application
]

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "corsheaders.middleware.CorsMiddleware",  # Ajout du middleware CORS
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
]

CORS_ALLOWED_ORIGINS = [
    "http://localhost:3000",  # Autorise les requêtes venant du frontend React
]

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",  # Base de données SQLite
        "NAME": BASE_DIR / "db.sqlite3",
    }
}
```

---

### **5. urls.py (Django - Routage)**

Ce fichier définit les chemins d’accès pour les vues Django.

```python
from django.contrib import admin
from django.urls import path
from chatbot_app.views import chatbot_response  # Import de la vue

urlpatterns = [
    path("admin/", admin.site.urls),  # Page d'administration Django
    path("api/chatbot/", chatbot_response, name="chatbot_response"),  # API pour le chatbot
]
```

- **Explication :**
  - `path("api/chatbot/")` : Définit le point d'accès pour le chatbot, accessible via `/api/chatbot/`.

---

### **Lancement du projet**

1. **Démarrer Django :**
   ```bash
   python manage.py runserver
   ```

2. **Démarrer React :**
   ```bash
   npm start
   ```

3. **Tester l’application :**
   - Accédez au frontend via [http://localhost:3000](http://localhost:3000).
   - Envoyez un message pour voir la réponse générée par le backend Django.





--------------------------------
## Prochaines étapes
--------------------------------

1. Intégrez l'API OpenAI pour des réponses plus intelligentes.
2. Améliorez le design avec CSS ou Tailwind CSS.
3. Déployez votre projet sur des plateformes comme Heroku (backend) et Vercel (frontend).


