# **Comment installer et configurer Django et React : Guide complet pour débutant**


Ce guide est conçu pour un étudiant **débutant** en programmation. Nous allons créer un projet où Django (backend) et React (frontend) fonctionnent ensemble pour construire un chatbot interactif basé sur ChatGPT. Suivez ces étapes dans l'ordre.

### Références : 
- https://blogs.chainlyzer.com/building-an-ai-chatbot-in-less-than-an-hour-using-django-and-react-8625898d9291
---

# **1. Préparer votre environnement de développement**

#### **A. Prérequis**
1. Un ordinateur avec :
   - **Windows**, **macOS**, ou **Linux**.
2. Logiciels nécessaires :
   - **Python** (version 3.8 ou supérieure)
   - **Node.js** (pour exécuter React)
   - Un éditeur de texte comme **Visual Studio Code**.

#### **B. Installation des outils**
1. **Installer Python** :
   - Téléchargez Python depuis [python.org](https://www.python.org/downloads/).
   - Pendant l'installation, cochez **"Add Python to PATH"**.
   - Vérifiez l'installation :
     ```bash
     python --version
     ```

2. **Installer Node.js** :
   - Téléchargez Node.js depuis [nodejs.org](https://nodejs.org/).
   - Vérifiez l'installation :
     ```bash
     node --version
     npm --version
     ```

3. **Installer un éditeur de texte** :
   - Téléchargez [Visual Studio Code](https://code.visualstudio.com/).

4. **Installer Git** :
   - [Téléchargez Git](https://git-scm.com/downloads) pour la gestion des versions.

---

# **2. Installer et configurer Django**

#### **A. Installer Django**
1. Ouvrez le terminal (ou l'invite de commande).
2. Créez un **environnement virtuel** pour isoler votre projet :
   ```bash
   python -m venv env
   ```
3. Activez l'environnement virtuel :
   - Sur **Windows** :
     ```bash
     .\env\Scripts\activate
     ```
   - Sur **macOS/Linux** :
     ```bash
     source env/bin/activate
     ```
4. Installez Django :
   ```bash
   pip install django
   ```
5. Vérifiez l'installation :
   ```bash
   django-admin --version
   ```

#### **B. Créer un projet Django**
1. Créez un nouveau projet :
   ```bash
   django-admin startproject chatbot_project
   cd chatbot_project
   ```
2. Démarrez le serveur pour vérifier que tout fonctionne :
   ```bash
   python manage.py runserver
   ```
3. Ouvrez un navigateur et allez sur [http://127.0.0.1:8000](http://127.0.0.1:8000). Vous devriez voir une page Django par défaut.

---

# **3. Installer et configurer React**

#### **A. Installer React**
1. Dans un autre terminal, créez un projet React :
   ```bash
   npx create-react-app chatbot_frontend
   ```
   - Cela crée une application React dans le dossier `chatbot_frontend`.

2. Accédez au dossier React :
   ```bash
   cd chatbot_frontend
   ```

3. Lancez le serveur de développement React :
   ```bash
   npm start
   ```
   - Une page s’ouvrira dans votre navigateur avec "Welcome to React".

#### **B. Installer Axios pour les requêtes HTTP**
Nous utiliserons **Axios** pour envoyer des messages du frontend (React) au backend (Django).
```bash
npm install axios
```

---

# **4. Configurer Django et React pour travailler ensemble**

#### **A. Configurer Django pour accepter React**
1. Installez le middleware **CORS** pour autoriser les requêtes venant de React :
   ```bash
   pip install django-cors-headers
   ```
2. Ajoutez `corsheaders` dans `INSTALLED_APPS` et `MIDDLEWARE` dans `chatbot_project/settings.py` :
   ```python
   INSTALLED_APPS = [
       ...,
       'corsheaders',
   ]

   MIDDLEWARE = [
       'corsheaders.middleware.CorsMiddleware',
       'django.middleware.common.CommonMiddleware',
       ...
   ]

   CORS_ALLOWED_ORIGINS = [
       'http://localhost:3000',  # Adresse du serveur React
   ]
   ```

3. Redémarrez le serveur Django :
   ```bash
   python manage.py runserver
   ```

---

# **5. Créer une API dans Django**

#### **A. Créer une application Django pour le chatbot**
1. Créez une nouvelle application appelée "chatbot" :
   ```bash
   python manage.py startapp chatbot
   ```

2. Ajoutez l'application dans `INSTALLED_APPS` dans `settings.py` :
   ```python
   INSTALLED_APPS = [
       ...,
       'chatbot',
   ]
   ```

#### **B. Ajouter une vue pour traiter les requêtes**
1. Dans `chatbot/views.py`, ajoutez :
   ```python
   from django.http import JsonResponse
   from django.views.decorators.csrf import csrf_exempt
   import openai
   import json

   @csrf_exempt
   def chatbot_response(request):
       if request.method == 'POST':
           data = json.loads(request.body)
           user_message = data.get('message', '')
           response = f"You said: {user_message}"  # Réponse simple pour début
           return JsonResponse({'message': response})
       return JsonResponse({'error': 'Invalid request'}, status=400)
   ```

2. Ajoutez une route dans `chatbot_project/urls.py` :
   ```python
   from django.urls import path
   from chatbot.views import chatbot_response

   urlpatterns = [
       path('api/chatbot/', chatbot_response, name='chatbot_response'),
   ]
   ```

3. Redémarrez le serveur Django.

---

# **6. Connecter React au backend Django**

1. Modifiez `src/Chatbot.js` dans React pour créer l'interface du chatbot :
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
                           {msg.sender === 'user' ? 'You: ' : 'Bot: '} {msg.text}
                       </p>
                   ))}
               </div>
               <input
                   type="text"
                   value={userInput}
                   onChange={(e) => setUserInput(e.target.value)}
                   onKeyPress={(e) => e.key === 'Enter' && sendMessage()}
               />
               <button onClick={sendMessage}>Send</button>
           </div>
       );
   };

   export default Chatbot;
   ```

2. Ajoutez ce composant dans `App.js` :
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

3. Relancez React :
   ```bash
   npm start
   ```

---

# **7. Résultat attendu**
- **Backend Django** écoute sur [http://127.0.0.1:8000](http://127.0.0.1:8000).
- **Frontend React** est accessible sur [http://localhost:3000](http://localhost:3000).
- Vous avez un chatbot fonctionnel qui répond aux messages envoyés.

---

# **8. Prochaine étape**
1. Intégrer l’API OpenAI pour générer des réponses intelligentes.
2. Ajouter un design plus professionnel avec **CSS** ou **Tailwind CSS**.
3. Déployer le projet sur des plateformes comme **Heroku** (backend) et **Vercel** (frontend).

---

# **Conclusion**
Avec ces étapes, même un étudiant débutant peut créer un projet Django-React fonctionnel. Si vous avez des questions, n'hésitez pas à demander. Bon codage ! 🚀
