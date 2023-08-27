resource "google_storage_bucket" "auto-expire" {
  name          = var.bucket_name
  location      = project_region

}

esource "google_storage_bucket" "drivers" {
  name  = var.bucket_drivers
  location = "US"
  uniform_bucket_level_access = true
}