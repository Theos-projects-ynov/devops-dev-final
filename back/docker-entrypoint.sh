#!/bin/sh
set -e

echo "🚀 Initialisation de la base de données..."

# Créer le répertoire data s'il n'existe pas
mkdir -p /app/data

# Migrer la base de données
echo "📦 Migration de la base de données..."
npx prisma db push

# Seeder la base de données si elle est vide
echo "🌱 Seeding de la base de données..."
npx prisma db seed || echo "⚠️  Seeding échoué ou déjà effectué"

echo "✅ Initialisation terminée, démarrage du serveur..."

# Démarrer l'application
exec "$@" 