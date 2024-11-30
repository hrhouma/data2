
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

## Prochaines étapes

1. Intégrez l'API OpenAI pour des réponses plus intelligentes.
2. Améliorez le design avec CSS ou Tailwind CSS.
3. Déployez votre projet sur des plateformes comme Heroku (backend) et Vercel (frontend).
