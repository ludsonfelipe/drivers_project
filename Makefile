start_services:
	chmod +x ./enable_services.sh && ./enable_services.sh 

tf-init:
	terraform -chdir=./terraform init 

tf-plan:
	terraform -chdir=./terraform plan 

tf-apply:
	terraform -chdir=./terraform apply

data_stream_start_config:
	chmod +x ./create_source.sh && ./create_source.sh

ingest_data:
	chmod +x ./ingest_data.sh && ./ingest_data.sh

