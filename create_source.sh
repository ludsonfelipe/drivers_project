#!/bin/bash

export TF_VAR_public_address_db=$(terraform -chdir=./terraform output public_host)

psql "host=${TF_VAR_public_address_db//\"/} sslmode=disable dbname=travels_db user=datastream password=password" -f ./source/generate_data/create_tables.sql