enable_services:
	chmod +x ./enable_services.sh && ./enable_services.sh 

tf-init:
	terraform -chdir=./terraform init 

tf-plan:
	terraform -chdir=./terraform plan 

tf-apply:
	terraform -chdir=./terraform apply

create_source_code:
	chmod +x ./create_source.sh && ./create_source.sh

ingest_sql_data:
	chmod +x ./ingest_sql_data.sh && ./ingest_sql_data.sh

install_requirements:
	pip install -r ./source/generate_data/requirements.txt 

send_user_and_driver_topic:
	python ./source/generate_data/user_data.py

send_travel_topic:
	python ./source/generate_data/location_data.py

send_all_topics: install_requirements send_user_and_driver_topic send_travel_topic

	