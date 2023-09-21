resource "google_pubsub_topic" "drivers" {
  name = var.topic_drivers
}

resource "google_pubsub_topic" "users" {
  name = var.topic_users
}

resource "google_pubsub_topic" "travels" {
  name = var.topic_travel
}

resource "google_project_service_identity" "pubsub_id" {
  provider = google-beta
  project = var.project_id
  service = "pubsub.googleapis.com"
}


resource "google_pubsub_subscription" "gcs_drivers" {
  name  = "drivers-subscription-gcs"
  topic = google_pubsub_topic.drivers.name

  cloud_storage_config {
    bucket = google_storage_bucket.bronze.name

    filename_prefix = "drivers-"
    filename_suffix = "-${random_id.random_number.hex}"

    max_bytes = 1000
    max_duration = "60s"
  }
  depends_on = [ 
    google_storage_bucket.bronze,
    google_storage_bucket_iam_member.admindrivers,
  ]
}

resource "google_pubsub_subscription" "gcs_travels" {
  name  = "travel-subscription-gcs"
  topic = google_pubsub_topic.travels.name

  cloud_storage_config {
    bucket = google_storage_bucket.bronze.name

    filename_prefix = "travels-"
    filename_suffix = "-${random_id.random_number.hex}"

    max_bytes = 1000
    max_duration = "60s"
  }
  depends_on = [ 
    google_storage_bucket.bronze,
    google_storage_bucket_iam_member.admintravels,
  ]
}

resource "google_pubsub_subscription" "gcs_users" {
  name  = "users-subscription-gcs"
  topic = google_pubsub_topic.users.name

  cloud_storage_config {
    bucket = google_storage_bucket.bronze.name

    filename_prefix = "users-"
    filename_suffix = "-${random_id.random_number.hex}"

    max_bytes = 1000
    max_duration = "60s"
  }
  depends_on = [ 
    google_storage_bucket.bronze,
    google_storage_bucket_iam_member.adminusers,
  ]
}

resource "google_storage_bucket_iam_member" "admindrivers" {
  bucket = google_storage_bucket.bronze.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_project_service_identity.pubsub_id.email}"
}

resource "google_storage_bucket_iam_member" "adminusers" {
  bucket = google_storage_bucket.bronze.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_project_service_identity.pubsub_id.email}"
}

resource "google_storage_bucket_iam_member" "admintravels" {
  bucket = google_storage_bucket.bronze.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_project_service_identity.pubsub_id.email}"
}
