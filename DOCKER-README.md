# Dockerisation de l'application Store

Ce projet contient deux applications containerisées :

- **API Backend** : API Node.js avec Express et Prisma (port 3000)
- **Frontend Web** : Application Vue.js servie par Nginx (port 80)

## 🚀 Démarrage rapide

### Avec Docker Compose (recommandé)

```bash
# Construire et lancer les deux services
docker-compose up --build

# En arrière-plan
docker-compose up -d --build
```

L'application sera disponible sur :

- **Frontend** : http://localhost
- **API** : http://localhost:3000

### Builds individuels

#### Backend uniquement

```bash
cd back
docker build -t store-api .
docker run -p 3000:3000 -v store_db:/app/data store-api
```

#### Frontend uniquement

```bash
cd front
docker build -t store-web .
docker run -p 80:80 store-web
```

## 📦 Services

### API Backend (`store-api`)

- **Image** : Node.js 18 Alpine
- **Port** : 3000
- **Base de données** : SQLite (volume persistant)
- **Fonctionnalités** :
  - Migration automatique de la DB au démarrage
  - Seeding automatique des données
  - Utilisateur non-root pour la sécurité
  - Healthcheck intégré

### Frontend Web (`store-web`)

- **Image** : Nginx Alpine (multi-stage build)
- **Port** : 80
- **Fonctionnalités** :
  - Build optimisé avec Vite
  - Configuration SPA pour Vue Router
  - Compression gzip
  - Headers de sécurité
  - Cache des assets statiques

## 🛠️ Configuration

### Variables d'environnement (Backend)

```env
NODE_ENV=production
DATABASE_URL=file:./data/prod.db
```

### Volumes

- `db_data` : Persistance de la base de données SQLite

## 📋 Commandes utiles

```bash
# Voir les logs
docker-compose logs -f

# Arrêter les services
docker-compose down

# Supprimer les volumes (⚠️ perte de données)
docker-compose down -v

# Rebuilder après changements
docker-compose up --build --force-recreate

# Accéder au container backend
docker-compose exec api sh

# Exécuter des commandes Prisma
docker-compose exec api npx prisma studio
```

## 🔧 Développement

Pour le développement local, utilise les commandes npm classiques :

```bash
# Backend
cd back && npm install && npm start

# Frontend
cd front && npm install && npm run dev
```

## 📝 Notes

- La base de données SQLite est persistée dans un volume Docker
- Le seeding est automatique au premier démarrage
- Les deux services communiquent via le réseau Docker `app-network`
- Les builds sont optimisés avec des .dockerignore
