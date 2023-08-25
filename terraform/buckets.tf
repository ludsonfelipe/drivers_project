resource "google_storage_bucket" "auto-expire" {
  name          = var.bucket_name
  location      = project_region

}