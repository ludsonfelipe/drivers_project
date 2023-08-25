resource "google_sql_database_instance" "instance" {
    name             = var.instance_cloud_sql
    database_version = "POSTGRES_15"
    region           = project_region
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
    name     = var.database_name
}

resource "random_password" "pwd" {
    length = 16
    special = false
}

resource "google_sql_user" "user" {
    name = var.user_datastream_db
    instance = google_sql_database_instance.instance.name
    password = random_password.pwd.result

}