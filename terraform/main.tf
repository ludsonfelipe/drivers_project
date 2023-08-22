provider "google" {
  project = "playground-s-11-adbfaed1"
  region = "us-central1"
}

resource "google_sql_database_instance" "instance" {
    name             = "my-instance"
    database_version = "POSTGRES_15"
    region           = "us-central1"
    settings {
        tier = "db-f1-micro"

        disk_size = "10"
        database_flags {
          name = "cloudsql.logical_decoding"
          value = "on"
        }

        ip_configuration {

            // Datastream IPs will vary by region.
            authorized_networks {
                value = "34.71.242.81"
            }

            authorized_networks {
                value = "34.72.28.29"
            }

            authorized_networks {
                value = "34.67.6.157"
            }

            authorized_networks {
                value = "34.67.234.134"
            }

            authorized_networks {
                value = "34.72.239.218"
            }
        }
    }

    deletion_protection  = "true"
}

resource "google_sql_database" "db" {
    instance = google_sql_database_instance.instance.name
    name     = "db"
}

resource "random_password" "pwd" {
    length = 16
    special = false
}

resource "google_sql_user" "user" {
    name = "user"
    instance = google_sql_database_instance.instance.name
    password = random_password.pwd.result

}

output "key" {
  value= google_sql_user.user.password
  sensitive = true
}

resource "google_datastream_connection_profile" "default" {
    display_name          = "Connection profile"
    location              = "us-central1"
    connection_profile_id = "my-profile"

    postgresql_profile {
        hostname = google_sql_database_instance.instance.public_ip_address
        username = google_sql_user.user.name
        password = google_sql_user.user.password
        database = google_sql_database.db.name
    }

}

resource "google_storage_bucket" "auto-expire" {
  name          = "my_bucket312321312314323"
  location      = "us-central1"

}

resource "google_datastream_connection_profile" "bucketz" {
    display_name          = "Connection profile bucket"
    location              = "us-central1"
    connection_profile_id = "my-profile-b"

    gcs_profile {
        bucket    = "my_bucket312321312314323"
        root_path = "/path"
    }
}

resource "google_datastream_stream" "default"  {
    display_name = "Postgres to Cloud Storage"
    location     = "us-central1"
    stream_id    = "my-stream"
    desired_state = "RUNNING"

    source_config {
        source_connection_profile = google_datastream_connection_profile.default.id
        postgresql_source_config {
            max_concurrent_backfill_tasks = 12
            publication      = "publ"
            replication_slot = "repl"
            include_objects {
                postgresql_schemas {
                    schema = "public"
                    postgresql_tables {
                        table = "usuarios"

                    }
                }
            }
        }
        
    }
    backfill_all {  
    }

    destination_config {
        destination_connection_profile = google_datastream_connection_profile.bucketz.id
        gcs_destination_config  {
            file_rotation_mb = 200
            file_rotation_interval = "60s"
            json_file_format {
                schema_file_format = "NO_SCHEMA_FILE"
                compression = "GZIP"
            }
            }
        }
    }
    
