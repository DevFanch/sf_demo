# 🛒 E-commerce MX

Projet de boutique en ligne pour le marché mexicain, développé avec Symfony 6.4 et PostgreSQL.  
Ce projet est structuré pour simuler une équipe pro avec Git, CI/CD, Docker, Jira et Render.

In Progress
---

## 🚀 Stack Technique

- Symfony 6.4 (PHP 8.2)
- PostgreSQL 16
- Docker + Docker Compose
- GitHub + GitHub Actions
- Render.com (hébergement prod)
- Jira (gestion Agile / sprints)

---

## 🧱 Installation locale (dev)

```bash
git clone <repo-url>
cd ecommerce-mx
docker-compose up --build -d
```

## 🔑 Accès aux services

- Base de données : `localhost:5432`
- Application : `localhost:8000`


Parfait, procédons étape par étape pour créer un dépôt GitHub démo de ton projet Symfony avec Docker, PostgreSQL, CI/CD via GitHub Actions et déploiement automatique sur Render. Ce dépôt servira de base pour toi et d'autres développeurs souhaitant démarrer rapidement avec une configuration professionnelle.

---

## 🧱 1. Structure du dépôt

Voici la structure recommandée pour ton dépôt :

```
ecommerce-mx/
├── .github/
│   └── workflows/
│       └── tests.yml
├── docker/
│   ├── nginx/
│   │   └── default.conf
│   └── php/
│       └── Dockerfile
├── public/
│   └── index.php
├── src/
├── templates/
├── tests/
├── .env
├── .env.production
├── docker-compose.yml
├── Makefile
├── README.md
└── render.yaml
```

---

## ⚙️ 2. Fichiers essentiels

### `docker-compose.yml`

```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: docker/php/Dockerfile
    container_name: symfony_app
    restart: unless-stopped
    working_dir: /var/www/html
    volumes:
      - .:/var/www/html
    ports:
      - "8000:8000"
    depends_on:
      - db

  db:
    image: postgres:16
    container_name: postgres_db
    restart: unless-stopped
    environment:
      POSTGRES_USER: symfony
      POSTGRES_PASSWORD: symfony
      POSTGRES_DB: ecommerce
    ports:
      - "5432:5432"
    volumes:
      - db_data:/var/lib/postgresql/data

volumes:
  db_data:
```

### `docker/php/Dockerfile`

```Dockerfile
FROM php:8.2-cli

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    && docker-php-ext-install pdo_pgsql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
```

### `render.yaml`

```yaml
services:
  - type: web
    name: symfony-app
    env: php
    plan: free
    buildCommand: |
      composer install --no-dev --optimize-autoloader
    startCommand: php -S 0.0.0.0:8000 -t public
    envVars:
      - key: APP_ENV
        value: prod
      - key: DATABASE_URL
        fromDatabase:
          name: ecommerce-db
          property: connectionString
databases:
  - name: ecommerce-db
    plan: free
```

### `.env.production`

```env
APP_ENV=prod
APP_SECRET=ChangeMeInProd
APP_DEBUG=0
DATABASE_URL=${DATABASE_URL}
```

### `.github/workflows/tests.yml`

```yaml
name: Run Symfony tests

on:
  pull_request:
    branches: [ develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:16
        env:
          POSTGRES_USER: symfony
          POSTGRES_PASSWORD: symfony
          POSTGRES_DB: ecommerce_test
        ports:
          - 5432:5432

    steps:
      - uses: actions/checkout@v3
      - uses: shivammathur/setup-php@v2
        with:
          php-version: 8.2
          extensions: pdo_pgsql
      - run: composer install
      - run: php bin/phpunit
```

---

## 📘 3. README.md

```markdown
# 🛒 E-commerce MX

Projet de boutique en ligne pour le marché mexicain, développé avec Symfony 6.4 et PostgreSQL.  
Ce projet est structuré pour simuler une équipe pro avec Git, CI/CD, Docker, Jira et Render.

---

## 🚀 Stack Technique

- Symfony 6.4 (PHP 8.2)
- PostgreSQL 16
- Docker + Docker Compose
- GitHub + GitHub Actions
- Render.com (hébergement prod)
- Jira (gestion Agile / sprints)

---

## 🧱 Installation locale (dev)

```bash
git clone <repo-url>
cd ecommerce-mx
docker-compose up --build -d
```

Accès :
- App : http://localhost:8000

---

## 📦 Déploiement

Déploiement automatique via Render à chaque merge sur `main`.  
Voir fichier `render.yaml`.

---

## 🔁 Pipeline Git

- `feature/*` → PR vers `develop` → tests via GitHub Actions
- `develop` → merge vers `main` = déploiement sur Render

---

## 📋 Jira

Gestion des tâches via projet Jira : *E-commerce MX*  
Méthodologie Scrum, sprints d’une semaine.

---

## 🧪 Tests

Lancer les tests :
```bash
docker-compose exec app php bin/phpunit
```

GitHub Actions exécute les tests automatiquement à chaque PR.

---

## 👤 Auteur

Fanch — Dev et Formateur web  
👨‍🚀 Lead fictif : Pedro le Reviewer 🌮

---
```

---

## 🚀 4. Création du dépôt GitHub

1. Connecte-toi à [GitHub](https://github.com/) et crée un nouveau dépôt nommé `ecommerce-mx`.
2. Clone le dépôt sur ta machine locale :
   ```bash
   git clone https://github.com/<ton-utilisateur>/ecommerce-mx.git
   ```
3. Copie les fichiers et dossiers mentionnés ci-dessus dans le répertoire cloné.
4. Initialise le dépôt Git et effectue le premier commit :
   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

---

## 🌐 5. Déploiement sur Render

1. Connecte-toi à [Render](https://dashboard.render.com/) et crée un nouveau service web.
2. Connecte ton compte GitHub et sélectionne le dépôt `ecommerce-mx`.
3. Render détectera automatiquement le fichier `render.yaml` et configurera le service en conséquence.
4. Le déploiement se lancera automatiquement. Une fois terminé, ton application sera accessible via l'URL fournie par Render.

---
