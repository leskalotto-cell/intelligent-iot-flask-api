# =============================================================
# Makefile – genvejskommandoer til iot-flask-api
# Brug: make <kommando>
# =============================================================

# Lokalt: byg og kør med hot-reload
dev:
	docker compose -f docker-compose.yml -f docker-compose.local.yml --env-file .env.local up --build

# Lokalt: kør uden at genbygge
up:
	docker compose -f docker-compose.yml -f docker-compose.local.yml --env-file .env.local up

# Stop alle containere
down:
	docker compose down

# Stop og slet volumes (rydder DB)
clean:
	docker compose down -v

# Byg og push image til ghcr.io
push:
	docker build -t ghcr.io/ulpe-ek-dk/intelligent-iot-flask-api:latest .
	docker push ghcr.io/ulpe-ek-dk/intelligent-iot-flask-api:latest

# Deploy til remote maskine / Azure VM
remote-up:
	docker compose -f docker-compose.yml -f docker-compose.remote.yml --env-file .env.remote up -d

# Stop remote deployment
remote-down:
	docker compose -f docker-compose.yml -f docker-compose.remote.yml --env-file .env.remote down

# Vis kørende containere og logs
status:
	docker compose ps

logs:
	docker compose logs -f api
