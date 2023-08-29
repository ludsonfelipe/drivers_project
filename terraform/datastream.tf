resource "google_datastream_connection_profile" "cdc_travels" {
    display_name          = "Connection profile"
    location              = var.project_region
    connection_profile_id = var.datastream_conn_db

    postgresql_profile {
        hostname = google_sql_database_instance.instance.public_ip_address
        username = google_sql_user.user.name
        password = google_sql_user.user.password
        database = google_sql_database.db.name
    }

}

resource "google_datastream_connection_profile" "bucket" {
    display_name          = "Connection profile bucket"
    location              = var.project_region
    connection_profile_id = var.datastream_conn_bucket

    gcs_profile {
        bucket    = google_storage_bucket.relational.name
        root_path = "/database_data"
    }
}

resource "google_datastream_stream" "cdc_travels"  {
    display_name = "Postgres to Cloud Storage"
    location     = var.project_region
    stream_id    = var.datastream_name
    desired_state = "RUNNING"

    source_config {
        source_connection_profile = google_datastream_connection_profile.cdc_travels.id
        postgresql_source_config {
            max_concurrent_backfill_tasks = 12
            publication      = var.publication_name
            replication_slot = var.replication_name
            include_objects {
                postgresql_schemas {
                    schema = "public"
                    postgresql_tables {
                        table = "usuarios"
                    }
                    postgresql_tables {
                        table = "motoristas"

                    }
                    postgresql_tables {
                        table = "veiculos"

                    }
                    postgresql_tables {
                        table = "viagens"

                    }
                    postgresql_tables {
                        table = "pagamentos"

                    }
                }
            }
        }
        
    }
    backfill_all {  
    }

    destination_config {
        destination_connection_profile = google_datastream_connection_profile.bucket.id
        gcs_destination_config  {
            file_rotation_mb = 200
            file_rotation_interval = "60s"
            json_file_format {
                schema_file_format = "NO_SCHEMA_FILE"
            }
            }
        }
    }
    
