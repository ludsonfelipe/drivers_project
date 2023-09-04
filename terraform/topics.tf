resource "google_pubsub_topic" "drivers" {
  name = var.topic_drivers
}

resource "google_pubsub_topic" "users" {
  name = var.topic_users
}

resource "google_pubsub_topic" "travels" {
  name = var.topic_travel
}

resource "google_pubsub_subscription" "gcs_drivers" {
  name  = "drivers-subscription-gcs"
  topic = google_pubsub_topic.drivers.name

  cloud_storage_config {
    bucket = google_storage_bucket.drivers.name

    filename_prefix = "pre-"
    filename_suffix = "-${random_id.random_number.hex}"

    max_bytes = 1000
    max_duration = "60s"
  }
  depends_on = [ 
    google_storage_bucket.drivers,
    google_storage_bucket_iam_member.admindrivers,
  ]
}

resource "google_pubsub_subscription" "gcs_travels" {
  name  = "travel-subscription-gcs"
  topic = google_pubsub_topic.travels.name

  cloud_storage_config {
    bucket = google_storage_bucket.travels.name

    filename_prefix = "pre-"
    filename_suffix = "-${random_id.random_number.hex}"

    max_bytes = 1000
    max_duration = "60s"
  }
  depends_on = [ 
    google_storage_bucket.travels,
    google_storage_bucket_iam_member.admintravels,
  ]
}

resource "google_pubsub_subscription" "gcs_users" {
  name  = "users-subscription-gcs"
  topic = google_pubsub_topic.users.name

  cloud_storage_config {
    bucket = google_storage_bucket.users.name

    filename_prefix = "pre-"
    filename_suffix = "-${random_id.random_number.hex}"

    max_bytes = 1000
    max_duration = "60s"
  }
  depends_on = [ 
    google_storage_bucket.users,
    google_storage_bucket_iam_member.adminusers,
  ]
}


resource "google_storage_bucket_iam_member" "admindrivers" {
  bucket = google_storage_bucket.drivers.name
  role   = "roles/storage.admin"
  member = "serviceAccount:service-218122086508@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_storage_bucket_iam_member" "adminusers" {
  bucket = google_storage_bucket.users.name
  role   = "roles/storage.admin"
  member = "serviceAccount:service-218122086508@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_storage_bucket_iam_member" "admintravels" {
  bucket = google_storage_bucket.travels.name
  role   = "roles/storage.admin"
  member = "serviceAccount:service-218122086508@gcp-sa-pubsub.iam.gserviceaccount.com"
}
