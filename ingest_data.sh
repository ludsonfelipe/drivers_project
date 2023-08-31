#!/bin/bash
export TF_VAR_public_address_db=$(terraform -chdir=./terraform output public_host)

# Defina as variáveis de conexão
HOST="${TF_VAR_public_address_db//\"/}"
DBNAME="travels_db"
USER="datastream"
PASSWORD="password"

# Lista de arquivos SQL a serem executados
SQL_FILES=(
  "./source/generate_data/sql_data/users.sql"
  "./source/generate_data/sql_data/drivers.sql"
  "./source/generate_data/sql_data/cars.sql"
  "./source/generate_data/sql_data/trip_1.sql"
  "./source/generate_data/sql_data/pagamentos.sql"
  "./source/generate_data/sql_data/pending.sql"
  "./source/generate_data/sql_data/in_progress.sql"
)

# Monta a string de conexão
CONN_STRING="host=${HOST} sslmode=disable dbname=${DBNAME} user=${USER} password=${PASSWORD}"

echo $CONN_STRING
# Loop para executar cada arquivo SQL
for FILE in "${SQL_FILES[@]}"; do
  echo "Executing: ${FILE}"
  psql "${CONN_STRING}" -f "${FILE}"
done

echo "All SQL files executed."
