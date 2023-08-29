resource "random_id" "random_number" {
  byte_length = 8
}

resource "google_storage_bucket" "relational" {
  name          = "cdc-bucket-${random_id.random_number.hex}"
  location      = var.project_region

}

resource "google_storage_bucket" "drivers" {
  name  = "drivers-bucket-${random_id.random_number.hex}"
  location = var.project_region
}

resource "google_storage_bucket" "users" {
  name  = "users-bucket-${random_id.random_number.hex}"
  location = var.project_region
}

resource "google_storage_bucket" "travels" {
  name  = "travels-bucket-${random_id.random_number.hex}"
  location = var.project_region
}