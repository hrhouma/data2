
## Préparation de l'environnement de développement

### Références : 
- https://blogs.chainlyzer.com/building-an-ai-chatbot-in-less-than-an-hour-using-django-and-react-8625898d9291

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

### Objectif: 

![image](https://github.com/user-attachments/assets/dac4d620-de46-4cd0-977b-2fd5da84844e)



```bash
mkdir monchatbot
cd monchatbot
code .
```

```bash
cd monchatbot
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

1. Créez le projet et créez l'application :

```bash
cd monchatbot
django-admin startproject chatbot_project
cd chatbot_project
python manage.py startapp chatbot_app
```

![image](https://github.com/user-attachments/assets/dac4d620-de46-4cd0-977b-2fd5da84844e)

2. Ouvrez `chatbot_project/settings.py` et ajoutez `'chatbot_app'` à `INSTALLED_APPS` :

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

- **Explication des parties principales :**
  - **useState** : Gestion des états `messages` (historique) et `userInput` (saisie utilisateur).
  - **axios** : Requête POST à l'API Django pour obtenir la réponse du chatbot.
  - **UI** : Affiche les messages sous forme de paragraphes (`<p>`).

---

### **3. views.py (Django - Logique de l'API)**

Cette vue Django reçoit les messages de l'utilisateur via une requête POST, et retourne une réponse JSON simulée.

```python
from django.shortcuts import render

# Create your views here.

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

- **Explication des parties :**
  - `csrf_exempt` : Utilisé pour désactiver temporairement la vérification CSRF (utile pour les tests locaux).
  - `JsonResponse` : Retourne une réponse en JSON lisible par le frontend.
  - `POST` : Traite uniquement les requêtes POST.

---

### **4. settings.py (Django - Configuration)**

Voici le fichier de configuration ajusté pour activer **corsheaders** et l’application `chatbot_app`.

```python
"""
Django settings for chatbot_project project.

Generated by 'django-admin startproject' using Django 4.2.16.

For more information on this file, see
https://docs.djangoproject.com/en/4.2/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/4.2/ref/settings/
"""

from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/4.2/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = "django-insecure-s!%q$5_*r#9m9zsp)tfomvrhmzj4))q^&q@^bfrx2+_%_l&0eo"

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = []


# Application definition

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "corsheaders",
    "chatbot_app",
]

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",

]

CORS_ALLOWED_ORIGINS = [
    "http://localhost:3000",
]

ROOT_URLCONF = "chatbot_project.urls"

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    },
]

WSGI_APPLICATION = "chatbot_project.wsgi.application"


# Database
# https://docs.djangoproject.com/en/4.2/ref/settings/#databases

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": BASE_DIR / "db.sqlite3",
    }
}


# Password validation
# https://docs.djangoproject.com/en/4.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        "NAME": "django.contrib.auth.password_validation.UserAttributeSimilarityValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.MinimumLengthValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.CommonPasswordValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.NumericPasswordValidator",
    },
]


# Internationalization
# https://docs.djangoproject.com/en/4.2/topics/i18n/

LANGUAGE_CODE = "en-us"

TIME_ZONE = "UTC"

USE_I18N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/4.2/howto/static-files/

STATIC_URL = "static/"

# Default primary key field type
# https://docs.djangoproject.com/en/4.2/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"

```

---

### **5. urls.py (Django - Routage)**

Ce fichier définit les chemins d’accès pour les vues Django.

```python
"""
URL configuration for chatbot_project project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from django.contrib import admin
from django.urls import path, include

from chatbot_app.views import chatbot_response

urlpatterns = [
    path("admin/", admin.site.urls),
    path('api/chatbot/', chatbot_response, name='chatbot_response'),

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


