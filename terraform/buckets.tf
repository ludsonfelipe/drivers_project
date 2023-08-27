resource "google_storage_bucket" "relational" {
  name          = var.bucket_cdc_relational
  location      = var.project_region

}

resource "google_storage_bucket" "drivers" {
  name  = var.bucket_drivers
  location = var.project_region
}

resource "google_storage_bucket" "users" {
  name  = var.bucket_users
  location = var.project_region
}

resource "google_storage_bucket" "travels" {
  name  = var.bucket_travels
  location = var.project_region
}