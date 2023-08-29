start_services:
	chmod +x ./enable_services.sh && ./enable_services.sh 

tf-init:
	terraform -chdir=./terraform init 

tf-make-sources:
	terraform -chdir=./terraform untaint google_pubsub_subscription.gcs_drivers && 
	terraform -chdir=./terraform untaint google_storage_bucket_iam_member.admin &&
	terraform -chdir=./terraform untaint google_datastream_stream.cdc_travels &&
	terraform -chdir=./terraform apply 

data_stream_start_config:
	./create_source.sh


