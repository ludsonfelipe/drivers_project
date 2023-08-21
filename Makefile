postgres_up:
	docker compose --env-file env up -d pgadmin && docker compose --env-file env up postgres

postgres_down:
	docker compose down