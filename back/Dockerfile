FROM node:18-alpine

# Installer OpenSSL pour Prisma
RUN apk add --no-cache openssl

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npx prisma generate

# Ajuster le chemin de la DB pour Docker
RUN sed 's|DATABASE_URL=file:./file.db|DATABASE_URL=file:./data/file.db|g' .env > .env.tmp && mv .env.tmp .env

RUN mkdir -p data
EXPOSE 3000

RUN chmod +x docker-entrypoint.sh
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["npm", "start"] 