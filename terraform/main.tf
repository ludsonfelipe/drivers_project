provider "google" {
  project = "playground-s-11-e1a8ea11"
  region = "us-central1"
}

resource "google_sql_database_instance" "instance" {
    name             = "my-instance"
    database_version = "POSTGRES_15"
    region           = "us-central1"
    settings {
        tier = "db-f1-micro"
        disk_size = "10"
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
  name          = "my_bucket3123123123"
  location      = "us-central1"

}

resource "google_datastream_connection_profile" "bucketz" {
    display_name          = "Connection profile bucket"
    location              = "us-central1"
    connection_profile_id = "my-profile-b"

    gcs_profile {
        bucket    = "my_bucket3123123123"
        root_path = "/path"
    }
}