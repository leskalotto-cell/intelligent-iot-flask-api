# Intelligent IoT Flask API

Flask API med MySQL database til demonstration af IoT device management.

## Forudsætninger

- Docker Desktop installeret og kørende
- Git installeret
- GitHub Personal Access Token med `read:packages` rettighed

---

## Hurtig start – lokalt

```bash
# 1. Klon repo
git clone https://github.com/ulpe-ek-dk/intelligent-iot-flask-api.git
cd intelligent-iot-flask-api

# 2. Opret env-fil
cp .env.example .env.local
# Rediger .env.local og sæt dit eget DB_PASSWORD

# 3. Kør
make dev
# eller uden make:
docker compose -f docker-compose.yml -f docker-compose.local.yml --env-file .env.local up --build
```

Test: http://localhost:5005/health

---

## Deploy til en anden maskine / Azure VM

### På modtagermaskinen:

```powershell
# 1. Klon repo (for at få compose-filer og init-sql)
git clone https://github.com/ulpe-ek-dk/intelligent-iot-flask-api.git
cd intelligent-iot-flask-api

# 2. Opret env-fil
copy .env.example .env.remote
notepad .env.remote
# Sæt DB_PASSWORD til dit eget password
# IMAGE_NAME er allerede sat til ghcr.io/ulpe-ek-dk/intelligent-iot-flask-api

# 3. Start
docker compose -f docker-compose.yml -f docker-compose.remote.yml --env-file .env.remote up -d
```

> **Bemærk:** Ingen login nødvendigt – image er public på ghcr.io og opfører sig
> præcis som et officielt Docker Hub image (fx `mysql:8.0`). Docker puller det
> automatisk første gang.

Test: http://localhost:5005/health  
Udefra: http://VM-IP:5005/health

---

## Compose-filer oversigt

| Fil | Formål |
|-----|--------|
| `docker-compose.yml` | Base – bruges altid |
| `docker-compose.local.yml` | Lokalt: bygger image, hot-reload, eksponerer DB |
| `docker-compose.remote.yml` | Remote: puller image fra ghcr.io |

## Nyttige kommandoer

```bash
make dev          # Start lokalt med hot-reload
make remote-up    # Deploy til remote maskine
make down         # Stop alle containere
make clean        # Stop og slet database (frisk start)
make logs         # Følg API logs
make status       # Vis kørende containere
```

---

## API endpoints

| Method | Endpoint | Beskrivelse |
|--------|----------|-------------|
| GET | `/health` | Health check |
| GET | `/devices` | Hent alle devices |
| POST | `/devices` | Opret nyt device |
| GET | `/devices/<id>` | Hent enkelt device |
| PUT | `/devices/<id>` | Opdater device |
| DELETE | `/devices/<id>` | Slet device |
