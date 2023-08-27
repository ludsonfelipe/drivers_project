resource "google_pubsub_topic" "drivers" {
  name = var.topic_drives
}

resource "google_storage_bucket" "drivers" {
  name  = var.bucket_drivers
  location = "US"
  uniform_bucket_level_access = true
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
    google_storage_bucket_iam_member.admin,
  ]
}

# data "google_project" "project"{
#     number = "asljdgbhasjikdbsad"
# }

resource "google_storage_bucket_iam_member" "admin" {
  bucket = google_storage_bucket.drivers.name
  role   = "roles/storage.admin"
  member = "serviceAccount:service-218122086508@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "random_id" "random_number" {
  byte_length = 8
}

variable "topic_drives" {
  default = "drivers_loc"
}

variable "bucket_drivers" {
  default = "drivers-bucket-821398721378"
}