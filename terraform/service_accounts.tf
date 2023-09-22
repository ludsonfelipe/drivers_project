resource "google_service_account" "service_account_databricks" {
  account_id   = "databricks"
  display_name = "databricks"
}

resource "google_storage_bucket_iam_member" "admindatabricksbronze" {
  bucket = google_storage_bucket.bronze.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.service_account_databricks.email}"
}

resource "google_storage_bucket_iam_member" "admindatabrickssilver" {
  bucket = google_storage_bucket.silver.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.service_account_databricks.email}"
}