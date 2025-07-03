FROM node:18-alpine

# Installer OpenSSL pour Prisma
RUN apk add --no-cache openssl

WORKDIR /app

COPY package*.json ./
RUN npm install --only=production

COPY . .
RUN npx prisma generate

# Ajuster le chemin de la DB pour Docker
RUN sed 's|DATABASE_URL=file:./file.db|DATABASE_URL=file:./data/file.db|g' .env > .env.tmp && mv .env.tmp .env

# Nettoyer pour réduire la taille
RUN rm -rf node_modules/.cache prisma/migrations

RUN mkdir -p data
EXPOSE 3000

RUN chmod +x docker-entrypoint.sh
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["npm", "start"] 

# docker pull back:latest
# docker tag back:latest rg.fr-par.scw.cloud/namespace-theo-stoffelbach/back:latest
# docker push rg.fr-par.scw.cloud/namespace-theo-stoffelbach/back:latest